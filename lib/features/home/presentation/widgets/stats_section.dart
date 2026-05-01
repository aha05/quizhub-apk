import 'package:flutter/material.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/utils/home_presentation_constants.dart';

class StatsSection extends StatelessWidget {
  final UserActivity userActivity;

  const StatsSection({super.key, required this.userActivity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: "Total Quiz",
                value: userActivity.totalQuizzes.toString(),
              ),
            ),
            const SizedBox(width: HomePresentationConstants.contentGap),
            Expanded(
              child: _StatCard(
                title: "Avg Score",
                value: "${userActivity.averageScore}%",
              ),
            ),
          ],
        ),
        const SizedBox(height: HomePresentationConstants.contentGap),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: "Completed",
                value: userActivity.completed.toString(),
              ),
            ),
            const SizedBox(width: HomePresentationConstants.contentGap),
            Expanded(
              child: _StatCard(
                title: "Rank",
                value: "#${userActivity.leaderboard}",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          HomePresentationConstants.cardRadius,
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
