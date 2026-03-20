import 'package:flutter/material.dart';
import '../../model/quiz_history_model.dart';
import '../../model/quiz_model.dart';
import '../../model/question_model.dart';
import '../../model/option_model.dart';
import '../../services/question_service.dart';
import '../../services/api.dart';
import '../../core/handlers/auth_handler.dart';
import '../../core/exceptions/api_exception.dart';


class QuizReviewScreen extends StatefulWidget {
  final QuizHistory history;

  const QuizReviewScreen({super.key, required this.history});

  @override
  State<QuizReviewScreen> createState() => _QuizReviewScreenState();
}

class _QuizReviewScreenState extends State<QuizReviewScreen> {
  final QuestionService _questionService = QuestionService(Api());
  bool isLoadingQuestions = true;
  String? error;
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      try {
      final results = await _questionService.fetchQuestions(widget.history.quizId);
      
      setState(() {
        questions = results as List<Question>;
        isLoadingQuestions = false;
      });

      await Future.delayed(const Duration(seconds: 1));
    } on ApiException catch (e) {
      if (e.statusCode == 401){
           AuthHandler.redirectToLogin(context, e);
      }
      setState(() {
        error = 'Failed to load questions: $e';
        isLoadingQuestions = false;
      });
    }

      await Future.delayed(const Duration(seconds: 1));

      // Mock data — remove when API is ready
      // final mockJson = [
      //   {
      //     'id': 1,
      //     'content': 'What is the correct way to declare a variable in Dart?',
      //     'type': 'SINGLE',
      //     'options': [
      //       {'id': 1, 'text': 'var name = "John";', 'correct': true},
      //       {'id': 2, 'text': 'variable name = "John";', 'correct': false},
      //       {'id': 3, 'text': 'let name = "John";', 'correct': false},
      //       {'id': 4, 'text': 'dim name = "John";', 'correct': false},
      //     ],
      //   },
      //   {
      //     'id': 2,
      //     'content': 'What is the correct way to declare a variable in Dart?',
      //     'type': 'MULTIPLE',
      //     'options': [
      //       {'id': 5, 'text': 'var name = "John";', 'correct': true},
      //       {'id': 6, 'text': 'variable name = "John";', 'correct': true},
      //       {'id': 7, 'text': 'let name = "John";', 'correct': false},
      //       {'id': 8, 'text': 'dim name = "John";', 'correct': false},
      //     ],
      //   },
      // ];

      // setState(() {
      //   questions = mockJson
      //       .map((e) => Question.fromJson(e as Map<String, dynamic>))
      //       .toList();
      //   isLoadingQuestions = false;
      // });
    } catch (e) {
      setState(() {
        error = 'Failed to load questions: $e';
        isLoadingQuestions = false;
      });
    }
  }

  // Get user's selected option ids for a given question
  List<int> _selectedIds(int questionId) {
    return widget.history.answers
        .where((a) => a.questionId == questionId)
        .expand((a) => a.selectedOptionIds)
        .toList();
  }

  // Whether the user got this question fully correct
  bool _isQuestionCorrect(Question question) {
    final selected = _selectedIds(question.id);
    final correctIds =
        question.options.where((o) => o.correct).map((o) => o.id).toList();
    return selected.length == correctIds.length &&
        selected.every((id) => correctIds.contains(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(
          widget.history.quizTitle,
          style: const TextStyle(fontSize: 15),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: isLoadingQuestions
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading review...'),
                ],
              ),
            )
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      Text(error!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoadingQuestions = true;
                            error = null;
                          });
                          _fetchQuestions();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildSummaryBar(),
                    Expanded(child: _buildQuestionList()),
                  ],
                ),
    );
  }

  // ─── Summary Bar ──────────────────────────────────────────────────────────────
  Widget _buildSummaryBar() {
    final passColor = widget.history.passed
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Score ring
          SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: widget.history.scorePercentage / 100,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(passColor),
                ),
                Center(
                  child: Text(
                    '${widget.history.scorePercentage.toInt()}%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: passColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.history.passed
                      ? 'You passed this quiz!'
                      : 'You did not pass this quiz.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: passColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.history.correctAnswers} correct · '
                  '${widget.history.wrongAnswers} wrong · '
                  '${widget.history.formattedTime} taken',
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: passColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.history.passed ? 'PASSED' : 'FAILED',
              style: TextStyle(
                color: passColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Question List ────────────────────────────────────────────────────────────
  Widget _buildQuestionList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: questions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final question = questions[index];
        final selected = _selectedIds(question.id);
        final isCorrect = _isQuestionCorrect(question);

        return _ReviewCard(
          question: question,
          questionNumber: index + 1,
          selectedIds: selected,
          isCorrect: isCorrect,
        );
      },
    );
  }
}

// ─── Review Card ──────────────────────────────────────────────────────────────

class _ReviewCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final List<int> selectedIds;
  final bool isCorrect;

  const _ReviewCard({
    required this.question,
    required this.questionNumber,
    required this.selectedIds,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor =
        isCorrect ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
    final statusColorLight =
        isCorrect ? const Color(0xFFDCFCE7) : const Color(0xFFFFE4E6);
    final statusIcon =
        isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded;
    final statusLabel = isCorrect ? 'Correct' : 'Incorrect';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: statusColorLight,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Q$questionNumber',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(statusIcon, size: 16, color: statusColor),
                const SizedBox(width: 4),
                Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question content
                Text(
                  question.content,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),

                // Options
                ...question.options.map((option) {
                  final isSelected = selectedIds.contains(option.id);
                  final isCorrectOption = option.correct;
                  return _ReviewOption(
                    option: option,
                    isSelected: isSelected,
                    isCorrectOption: isCorrectOption,
                  );
                }),

                // Legend
                const SizedBox(height: 8),
                Row(
                  children: [
                    _LegendDot(
                        color: const Color(0xFF22C55E), label: 'Correct answer'),
                    const SizedBox(width: 12),
                    if (!isCorrect)
                      _LegendDot(
                          color: const Color(0xFFEF4444),
                          label: 'Your answer'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Review Option ────────────────────────────────────────────────────────────

class _ReviewOption extends StatelessWidget {
  final Option option;
  final bool isSelected;
  final bool isCorrectOption;

  const _ReviewOption({
    required this.option,
    required this.isSelected,
    required this.isCorrectOption,
  });

  @override
  Widget build(BuildContext context) {
    // Determine display state
    final bool isWrongSelection = isSelected && !isCorrectOption;

    Color borderColor;
    Color bgColor;
    Color iconColor;
    IconData icon;

    if (isCorrectOption) {
      borderColor = const Color(0xFF22C55E);
      bgColor = const Color(0xFFDCFCE7);
      iconColor = const Color(0xFF22C55E);
      icon = Icons.check_circle_rounded;
    } else if (isWrongSelection) {
      borderColor = const Color(0xFFEF4444);
      bgColor = const Color(0xFFFFE4E6);
      iconColor = const Color(0xFFEF4444);
      icon = Icons.cancel_rounded;
    } else {
      borderColor = Colors.grey.shade200;
      bgColor = Colors.grey.shade50;
      iconColor = Colors.grey.shade300;
      icon = Icons.radio_button_unchecked;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              option.text,
              style: TextStyle(
                fontSize: 14,
                color: isCorrectOption || isWrongSelection
                    ? Colors.black87
                    : Colors.grey.shade500,
                fontWeight: isCorrectOption || isWrongSelection
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ),
          // Labels
          if (isCorrectOption && isSelected)
            _OptionTag(label: 'Your answer · Correct', color: const Color(0xFF22C55E))
          else if (isCorrectOption)
            _OptionTag(label: 'Correct answer', color: const Color(0xFF22C55E))
          else if (isWrongSelection)
            _OptionTag(label: 'Your answer', color: const Color(0xFFEF4444)),
        ],
      ),
    );
  }
}

class _OptionTag extends StatelessWidget {
  final String label;
  final Color color;

  const _OptionTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
      ],
    );
  }
}