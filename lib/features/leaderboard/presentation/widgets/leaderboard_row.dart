import 'package:flutter/material.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_presentation_constants.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_style_resolver.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/leaderboard_avatar.dart';

class LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const LeaderboardRow({
    super.key,
    required this.entry,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final isTopThree = entry.rank <= 3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? LeaderboardPresentationConstants.primaryColor.withValues(
                alpha: 0.06,
              )
            : LeaderboardPresentationConstants.surfaceColor,
        borderRadius: BorderRadius.circular(
          LeaderboardPresentationConstants.cardRadius,
        ),
        border: Border.all(
          color: isCurrentUser
              ? LeaderboardPresentationConstants.primaryColor.withValues(
                  alpha: 0.3,
                )
              : Colors.transparent,
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
          SizedBox(
            width: 36,
            child: isTopThree
                ? _TopRank(rank: entry.rank)
                : _RankBox(entry.rank),
          ),
          const SizedBox(width: 12),
          LeaderboardAvatar(
            username: entry.username,
            textColor: LeaderboardStyleResolver.avatarTextColor(entry.rank),
            backgroundColor: LeaderboardStyleResolver.avatarBackgroundColor(
              entry.rank,
            ),
            size: 38,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _EntryDetails(entry: entry, isCurrentUser: isCurrentUser),
          ),
          _Score(score: entry.score, textColor: Colors.black87),
        ],
      ),
    );
  }
}

class _TopRank extends StatelessWidget {
  final int rank;

  const _TopRank({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Text(
      LeaderboardStyleResolver.rankLabel(rank),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: LeaderboardStyleResolver.podiumColor(rank),
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _RankBox extends StatelessWidget {
  final int rank;

  const _RankBox(this.rank);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          LeaderboardPresentationConstants.cardRadius,
        ),
      ),
      child: Center(
        child: Text(
          '#$rank',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

class _EntryDetails extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const _EntryDetails({required this.entry, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                entry.username,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            if (isCurrentUser) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: LeaderboardPresentationConstants.primaryColor
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  LeaderboardPresentationConstants.currentUserLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: LeaderboardPresentationConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        Text(
          '${entry.quizzesAttempted} quizzes attempted',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}

class _Score extends StatelessWidget {
  final int score;
  final Color textColor;

  const _Score({required this.score, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$score',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
        Text(
          LeaderboardPresentationConstants.pointsLabel,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
