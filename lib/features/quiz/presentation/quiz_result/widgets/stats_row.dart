import 'package:flutter/material.dart';
import 'package:quizhub/features/quiz/presentation/quiz_result/widgets/stat_card.dart';

class StatsRow extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final String formattedTime;

  const StatsRow({
    super.key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.check_circle_outline,
            iconColor: const Color(0xFF22C55E),
            label: 'Correct',
            value: '$correctAnswers',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: Icons.cancel_outlined,
            iconColor: const Color(0xFFEF4444),
            label: 'Wrong',
            value: '$wrongAnswers',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: Icons.timer_outlined,
            iconColor: const Color(0xFF4F46E5),
            label: 'Time',
            value: formattedTime,
          ),
        ),
      ],
    );
  }
}
