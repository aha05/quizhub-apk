import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/utils/quiz_result_helpers.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/widgets/breakdown_bar.dart';

class BreakdownCard extends StatelessWidget {
  final int total;
  final int correct;
  final int wrong;
  final int passScore;
  final int scorePercentage;
  final bool passed;
  const BreakdownCard({
    super.key,
    required this.total,
    required this.correct,
    required this.wrong,
    required this.passScore,
    required this.scorePercentage,
    required this.passed,
  });

  Color get _resultColor => QuizResultHelpers.resultColor(passed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance Breakdown',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Correct bar
          BreakdownBar(
            label: 'Correct',
            count: correct,
            total: total,
            color: const Color(0xFF22C55E),
          ),
          const SizedBox(height: 10),

          // Wrong bar
          BreakdownBar(
            label: 'Wrong',
            count: wrong,
            total: total,
            color: const Color(0xFFEF4444),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Pass requirement
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pass Score Required',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              Text(
                '$passScore%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Score',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              Text(
                '$scorePercentage%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _resultColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
