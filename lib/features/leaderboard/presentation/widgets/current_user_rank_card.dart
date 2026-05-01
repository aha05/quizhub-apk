import 'package:flutter/material.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_presentation_constants.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/leaderboard_avatar.dart';

class CurrentUserRankCard extends StatelessWidget {
  final LeaderboardEntry entry;

  const CurrentUserRankCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: LeaderboardPresentationConstants.primaryColor,
        borderRadius: BorderRadius.circular(
          LeaderboardPresentationConstants.cardRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: LeaderboardPresentationConstants.primaryColor.withValues(
              alpha: 0.3,
            ),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _RankBadge(rank: entry.rank),
          const SizedBox(width: 12),
          LeaderboardAvatar(
            username: entry.username,
            textColor: Colors.white,
            backgroundColor: Colors.white24,
            size: 36,
          ),
          const SizedBox(width: 10),
          Expanded(child: _CurrentUserDetails(entry: entry)),
          _CurrentUserScore(score: entry.score),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(
          LeaderboardPresentationConstants.cardRadius,
        ),
      ),
      child: Center(
        child: Text(
          '#$rank',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _CurrentUserDetails extends StatelessWidget {
  final LeaderboardEntry entry;

  const _CurrentUserDetails({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${entry.username} (${LeaderboardPresentationConstants.currentUserLabel})',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          '${entry.quizzesAttempted} quizzes attempted',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _CurrentUserScore extends StatelessWidget {
  final int score;

  const _CurrentUserScore({required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$score',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          LeaderboardPresentationConstants.pointsLabel,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
