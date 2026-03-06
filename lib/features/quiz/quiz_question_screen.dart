import 'dart:async';
import 'package:flutter/material.dart';
import 'quiz_result_modal.dart';
import '../../services/api.dart';
import '../../services/quiz_service.dart';
import '../../services/question_service.dart';
import '../../model/quiz_model.dart';
import '../../model/question_model.dart';
import '../../model/option_model.dart';
import '../../model/submit_answer_payload.dart';
import '../../model/answer_payload.dart';
import '../../model/enums.dart';
import '../../model/quiz_result_model.dart';


class QuizQuestionScreen extends StatefulWidget {
  final Quiz quiz;
  final int? userId;

  const QuizQuestionScreen({
    super.key,
    required this.quiz,
    required this.userId,
  });

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
   final QuizService _quizService = QuizService(Api());
   final QuestionService _questionService = QuestionService(Api());

  bool isLoadingQuestions = true;
  String? loadError;
  List<Question> questions = [];

  // Quiz state
  int currentIndex = 0;
  late int remainingSeconds;
  Timer? _timer;
  bool isSubmitting = false;
  final Map<int, List<int>> _answers = {};

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.quiz.timeLimit * 60;
    _fetchQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchQuestions() async {
    try {
      final results = await _questionService.fetchQuestions(widget.quiz.id);
      
      setState(() {
        questions = results as List<Question>;
        isLoadingQuestions = false;
      });

      await Future.delayed(const Duration(seconds: 1));
      _startTimer();
    } catch (e) {
      setState(() {
        loadError = 'Failed to load questions: $e';
        isLoadingQuestions = false;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        timer.cancel();
        _submitAnswers(autoSubmit: true);
      } else {
        setState(() => remainingSeconds--);
      }
    });
  }

  int get _timeTaken => (widget.quiz.timeLimit * 60) - remainingSeconds;

  String get _formattedTime {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Color get _timerColor {
    if (remainingSeconds <= 60) return Colors.red;
    if (remainingSeconds <= 120) return Colors.orange;
    return Colors.green;
  }

  Question get _currentQuestion => questions[currentIndex];

  bool _isSelected(int optionId) =>
      _answers[_currentQuestion.id]?.contains(optionId) ?? false;

  void _toggleOption(int optionId) {
    setState(() {
      final qId = _currentQuestion.id;
      if (_currentQuestion.type == QuestionType.SINGLE) {
        _answers[qId] = [optionId];
      } else {
        final current = List<int>.from(_answers[qId] ?? []);
        current.contains(optionId)
            ? current.remove(optionId)
            : current.add(optionId);
        _answers[qId] = current;
      }
    });
  }


  void _next() {
    if (currentIndex < questions.length - 1) setState(() => currentIndex++);
  }

  void _prev() {
    if (currentIndex > 0) setState(() => currentIndex--);
  }

  bool get _isLastQuestion => currentIndex == questions.length - 1;


  Future<void> _submitAnswers({bool autoSubmit = false}) async {
    if (isSubmitting) return;

    if (!autoSubmit) {
      final unanswered = questions
          .where((q) => !(_answers[q.id]?.isNotEmpty ?? false))
          .length;

      if (unanswered > 0) {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Submit Quiz?'),
            content: Text(
                '$unanswered question(s) unanswered. Submit anyway?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Submit'),
              ),
            ],
          ),
        );
        if (confirm != true) return;
      }
    }

    setState(() => isSubmitting = true);
    _timer?.cancel();

    try {
      final payload = SubmitAnswerPayload(
        userId: widget.userId ?? 0,
        timeTaken: _timeTaken,
        answers: _answers.entries
            .map((e) => AnswerPayload(
                  questionId: e.key,
                  selectedOptionIds: e.value,
                ))
            .toList(),
      );

      final QuizResult result =  await _quizService.submitAnswer(widget.quiz.id, payload);

      setState(() {
        isSubmitting = false;
      });

      if (mounted) {
        Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    QuizResultScreen(result: result, quiz: widget.quiz),
              ),
            );
      }
    } catch (e) {
      setState(() => isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingQuestions) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          title: Text(widget.quiz.title,
              style: const TextStyle(fontSize: 15)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading questions...'),
            ],
          ),
        ),
      );
    }

    if (loadError != null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          title: Text(widget.quiz.title),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(loadError!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoadingQuestions = true;
                    loadError = null;
                  });
                  _fetchQuestions();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        final exit = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Exit Quiz?'),
            content: const Text('Your progress will be lost.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Stay'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
        return exit ?? false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: _buildAppBar(),
        body: isSubmitting
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Submitting your answers...'),
                  ],
                ),
              )
            : Column(
                children: [
                  _buildProgressBar(),
                  Expanded(child: _buildQuestionCard()),
                  _buildBottomNav(),
                ],
              ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.quiz.title, style: const TextStyle(fontSize: 15)),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _timerColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _timerColor.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              Icon(Icons.timer_outlined, size: 14, color: _timerColor),
              const SizedBox(width: 4),
              Text(
                _formattedTime,
                style: TextStyle(
                  color: _timerColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    final answered = _answers.values.where((v) => v.isNotEmpty).length;
    final total = questions.length;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Question ${currentIndex + 1} of $total',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
              Text('$answered answered',
                  style:
                      TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (currentIndex + 1) / total,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF4F46E5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    final question = _currentQuestion;
    final isMultiple = question.type == QuestionType.MULTIPLE;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMultiple)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Text(
                'Select all that apply',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
            ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              question.content,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.5),
            ),
          ),
          const SizedBox(height: 16),
          ...question.options.asMap().entries.map((entry) => _OptionTile(
                option: entry.value,
                index: entry.key,
                isSelected: _isSelected(entry.value.id),
                isMultiple: isMultiple,
                onTap: () => _toggleOption(entry.value.id),
              )),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (currentIndex > 0)
            OutlinedButton.icon(
              onPressed: _prev,
              icon: const Icon(Icons.arrow_back_ios, size: 14),
              label: const Text('Back'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
          const Spacer(),
          if (_isLastQuestion)
            ElevatedButton.icon(
              onPressed: () => _submitAnswers(),
              icon: const Icon(Icons.check_circle_outline, size: 18),
              label: const Text('Submit Quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
              ),
            )
          else
            ElevatedButton.icon(
              onPressed: _next,
              icon: const Icon(Icons.arrow_forward_ios, size: 14),
              label: const Text('Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
              ),
            ),
        ],
      ),
    );
  }
}


class _OptionTile extends StatelessWidget {
  final Option option;
  final int index;
  final bool isSelected;
  final bool isMultiple;
  final VoidCallback onTap;

  const _OptionTile({
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isMultiple,
    required this.onTap,
  });

  static const _labels = ['A', 'B', 'C', 'D', 'E'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4F46E5).withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4F46E5)
                : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4F46E5)
                    : Colors.grey.shade100,
                shape: isMultiple ? BoxShape.rectangle : BoxShape.circle,
                borderRadius:
                    isMultiple ? BorderRadius.circular(6) : null,
              ),
              child: Center(
                child: isMultiple
                    ? Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: isSelected
                            ? Colors.white
                            : Colors.grey.shade400,
                        size: 18,
                      )
                    : Text(
                        index < _labels.length ? _labels[index] : '?',
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.text,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? const Color(0xFF4F46E5)
                      : Colors.black87,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}