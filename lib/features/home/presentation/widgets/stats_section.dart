import 'package:flutter/material.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';
import 'package:quizhub/features/home/presentation/widgets/stat_card.dart';

class StatsSection extends StatelessWidget {
  final UserActivity userActivity;
  const StatsSection({super.key, required this.userActivity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Row(
        children: [
          StatCard(
            label: 'Avg Score',
            value: '${userActivity.averageScore.toStringAsFixed(1)}%',
            icon: Icons.trending_up_rounded,
            color: Color(0xFF2ECC71),
          ),
          const SizedBox(width: 10),
          StatCard(
            label: 'Best Score',
            value: '${userActivity.highestScorePercentage.toStringAsFixed(1)}%',
            icon: Icons.emoji_events_rounded,
            color: const Color(0xFFFFB300),
          ),
          const SizedBox(width: 10),
          StatCard(
            label: 'Quizzes',
            value: '${userActivity.completed}',
            icon: Icons.check_circle_rounded,
            color: HomeColors.primary,
          ),
        ],
      ),
    );
  }
}
