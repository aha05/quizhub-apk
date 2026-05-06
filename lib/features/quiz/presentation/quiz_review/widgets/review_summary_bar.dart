import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_history.dart';

class ReviewSummaryBar extends StatelessWidget {
  final QuizHistory history;
  const ReviewSummaryBar({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final passColor = history.passed
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
                  value: history.scorePercentage / 100,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(passColor),
                ),
                Center(
                  child: Text(
                    '${history.scorePercentage.toInt()}%',
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
                  history.passed
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
                  '${history.correctAnswers} correct · '
                  '${history.wrongAnswers} wrong · '
                  '${history.formattedTime} taken',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: passColor.withOpacity(0.1),
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
    );
  }
}
