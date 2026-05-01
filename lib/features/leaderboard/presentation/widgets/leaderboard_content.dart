import 'package:flutter/material.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/current_user_rank_card.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/leaderboard_empty_view.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/leaderboard_podium.dart';
import 'package:quizhub/features/leaderboard/presentation/widgets/leaderboard_row.dart';

class LeaderboardContent extends StatelessWidget {
  final List<LeaderboardEntry> entries;
  final int? currentUserId;
  final Future<void> Function() onRefresh;

  const LeaderboardContent({
    super.key,
    required this.entries,
    required this.currentUserId,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const LeaderboardEmptyView();
    }

    final currentUserEntry = entries
        .where((entry) => entry.userId == currentUserId)
        .firstOrNull;
    final showCurrentUserCard =
        currentUserEntry != null && entries.indexOf(currentUserEntry) >= 3;

    return Column(
      children: [
        LeaderboardPodium(entries: entries),
        if (showCurrentUserCard) CurrentUserRankCard(entry: currentUserEntry),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: entries.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final entry = entries[index];

                return LeaderboardRow(
                  entry: entry,
                  isCurrentUser: entry.userId == currentUserId,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
