import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/legend_dot.dart';
import 'package:quizhub/features/quiz/presentation/quiz_review/widgets/review_option.dart';

class ReviewCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final List<int> selectedIds;
  final bool isCorrect;

  const ReviewCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.selectedIds,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isCorrect
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);
    final statusColorLight = isCorrect
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFFFE4E6);
    final statusIcon = isCorrect
        ? Icons.check_circle_rounded
        : Icons.cancel_rounded;
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: statusColorLight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
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
                  return ReviewOption(
                    option: option,
                    isSelected: isSelected,
                    isCorrectOption: isCorrectOption,
                  );
                }),

                // Legend
                const SizedBox(height: 8),
                Row(
                  children: [
                    LegendDot(
                      color: const Color(0xFF22C55E),
                      label: 'Correct answer',
                    ),
                    const SizedBox(width: 12),
                    if (!isCorrect)
                      LegendDot(
                        color: const Color(0xFFEF4444),
                        label: 'Your answer',
                      ),
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
