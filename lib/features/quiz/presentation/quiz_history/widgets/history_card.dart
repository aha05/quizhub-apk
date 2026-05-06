import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';
import 'package:quizhub/features/quiz/presentation/quiz_history/widgets/mini_stat.dart';

class HistoryCard extends StatelessWidget {
  final QuizHistory history;
  final VoidCallback onReview;

  const HistoryCard({super.key, required this.history, required this.onReview});

  @override
  Widget build(BuildContext context) {
    final passColor = history.passed
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);
    final passColorLight = history.passed
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFFE4E6);

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
                        Icon(
                          Icons.folder_outlined,
                          size: 12,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          history.quizCategory,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          history.formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Pass/Fail badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
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
              MiniStat(
                icon: Icons.percent_rounded,
                label: 'Score',
                value: '${history.scorePercentage.toInt()}%',
                color: passColor,
              ),
              const SizedBox(width: 16),
              MiniStat(
                icon: Icons.check_circle_outline,
                label: 'Correct',
                value: '${history.correctAnswers}/${history.totalQuestions}',
                color: const Color(0xFF22C55E),
              ),
              const SizedBox(width: 16),
              MiniStat(
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
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFF4F46E5), width: 1),
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
