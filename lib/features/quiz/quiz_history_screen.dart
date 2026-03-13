import 'package:flutter/material.dart';
import '../../model/quiz_model.dart';
import '../../model/quiz_history_model.dart';
import 'quiz_review_screen.dart';

class QuizHistoryScreen extends StatefulWidget {
  final int? userId;

  const QuizHistoryScreen({super.key, required this.userId});

  @override
  State<QuizHistoryScreen> createState() => _QuizHistoryScreenState();
}

class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
  bool isLoading = true;
  String? error;
  List<QuizHistory> history = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    try {
      // TODO: Replace with actual API call
      // final dynamic response = await api.get('/quiz/history/${widget.userId}');
      // final List<dynamic> list = response as List<dynamic>;
      // history = list.map((e) => QuizHistory.fromJson(e as Map<String, dynamic>)).toList();

      await Future.delayed(const Duration(seconds: 1));

      // Mock data — remove when API is ready
      final mockJson = [
        {
          'id': 1,
          'quizId': 1,
          'quizTitle': 'JavaScript Fundamental',
          'totalQuestions': 1,
          'correctAnswers': 1,
          'scorePercentage': 100,
          'quizCategory': 'Programming',
          'passed': true,
          'submittedAt': '2026-03-05T14:43:02.357798',
          'timeTaken': 50,
          'answers': [
            {'questionId': 1, 'selectedOptionIds': [2]}
          ],
        },
        {
          'id': 2,
          'quizId': 2,
          'quizTitle': 'Dart Basics',
          'totalQuestions': 5,
          'correctAnswers': 3,
          'scorePercentage': 60,
          'quizCategory': 'Programming',
          'passed': false,
          'submittedAt': '2026-03-06T10:20:00.000000',
          'timeTaken': 180,
          'answers': [
            {'questionId': 2, 'selectedOptionIds': [5, 6]},
            {'questionId': 3, 'selectedOptionIds': [9]},
          ],
        },
      ];

      setState(() {
        history = mockJson.map((e) => QuizHistory.fromJson(e)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load history: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('My Quiz History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() { isLoading = true; error = null; });
                _fetchHistory();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (history.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('No quiz attempts yet.',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() { isLoading = true; error = null; });
        await _fetchHistory();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _HistoryCard(
          history: history[index],
          onReview: () {
            if(history.isNotEmpty){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizReviewScreen(history: history[index]),
              ),
            );
            }
          },
        ),
      ),
    );
  }
}

// ─── History Card ─────────────────────────────────────────────────────────────

class _HistoryCard extends StatelessWidget {
  final QuizHistory history;
  final VoidCallback onReview;

  const _HistoryCard({required this.history, required this.onReview});

  @override
  Widget build(BuildContext context) {
    final passColor =
        history.passed ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
    final passColorLight =
        history.passed ? const Color(0xFFDCFCE7) : const Color(0xFFFFE4E6);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history.quizTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.folder_outlined,
                            size: 12, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          history.quizCategory,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade500),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.calendar_today_outlined,
                            size: 12, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          history.formattedDate,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Pass/Fail badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: passColorLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  history.passed ? 'PASSED' : 'FAILED',
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
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Stats row
          Row(
            children: [
              _MiniStat(
                icon: Icons.percent_rounded,
                label: 'Score',
                value: '${history.scorePercentage.toInt()}%',
                color: passColor,
              ),
              const SizedBox(width: 16),
              _MiniStat(
                icon: Icons.check_circle_outline,
                label: 'Correct',
                value:
                    '${history.correctAnswers}/${history.totalQuestions}',
                color: const Color(0xFF22C55E),
              ),
              const SizedBox(width: 16),
              _MiniStat(
                icon: Icons.timer_outlined,
                label: 'Time',
                value: history.formattedTime,
                color: const Color(0xFF4F46E5),
              ),
              const Spacer(),
              // Review button
              TextButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.rate_review_outlined, size: 16),
                label: const Text('Review'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4F46E5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                        color: Color(0xFF4F46E5), width: 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        const SizedBox(height: 2),
        Row(
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 3),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}