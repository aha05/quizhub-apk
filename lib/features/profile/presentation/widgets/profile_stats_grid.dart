import 'package:flutter/material.dart';
import 'package:quizhub/features/profile/domain/entities/profile_activity.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';

class ProfileStatsGrid extends StatelessWidget {
  final ProfileActivity activity;

  const ProfileStatsGrid({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          ProfilePresentationConstants.activityOverviewLabel,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            _StatTile(
              icon: Icons.quiz_outlined,
              label: 'Total Quizzes',
              value: '${activity.totalQuizzes}',
              color: ProfilePresentationConstants.primaryColor,
            ),
            _StatTile(
              icon: Icons.check_circle_outline,
              label: 'Completed',
              value: '${activity.completed}',
              color: ProfilePresentationConstants.successColor,
            ),
            _StatTile(
              icon: Icons.star_outline_rounded,
              label: 'Highest Score',
              value: '${activity.highestScorePercentage.toInt()}%',
              color: ProfilePresentationConstants.warningColor,
            ),
            _StatTile(
              icon: Icons.bar_chart_rounded,
              label: 'Average Score',
              value: '${activity.averageScore.toStringAsFixed(1)}%',
              color: ProfilePresentationConstants.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ProfilePresentationConstants.surfaceColor,
        borderRadius: BorderRadius.circular(
          ProfilePresentationConstants.cardRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                ProfilePresentationConstants.cardRadius,
              ),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
