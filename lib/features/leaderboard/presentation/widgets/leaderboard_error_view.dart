import 'package:flutter/material.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_presentation_constants.dart';

class LeaderboardErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const LeaderboardErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(LeaderboardPresentationConstants.retryLabel),
          ),
        ],
      ),
    );
  }
}
