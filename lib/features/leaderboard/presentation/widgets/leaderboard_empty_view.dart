import 'package:flutter/material.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_presentation_constants.dart';

class LeaderboardEmptyView extends StatelessWidget {
  const LeaderboardEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.leaderboard_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            LeaderboardPresentationConstants.emptyMessage,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
