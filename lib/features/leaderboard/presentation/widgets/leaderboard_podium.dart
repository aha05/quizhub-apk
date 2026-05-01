import 'package:flutter/material.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_presentation_constants.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_style_resolver.dart';

class LeaderboardPodium extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  const LeaderboardPodium({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.length < 3) {
      return const SizedBox.shrink();
    }

    final first = entries[0];
    final second = entries[1];
    final third = entries[2];

    return Container(
      color: LeaderboardPresentationConstants.surfaceColor,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: _PodiumColumn(entry: second, height: 80, place: 2)),
          const SizedBox(width: 8),
          Expanded(child: _PodiumColumn(entry: first, height: 110, place: 1)),
          const SizedBox(width: 8),
          Expanded(child: _PodiumColumn(entry: third, height: 60, place: 3)),
        ],
      ),
    );
  }
}

class _PodiumColumn extends StatelessWidget {
  final LeaderboardEntry entry;
  final double height;
  final int place;

  const _PodiumColumn({
    required this.entry,
    required this.height,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    final placeColor = LeaderboardStyleResolver.podiumColor(place);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          entry.username,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          '${entry.score} ${LeaderboardPresentationConstants.pointsLabel}',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: placeColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: placeColor, width: 2),
          ),
          child: Center(
            child: Text(
              entry.username.isNotEmpty ? entry.username[0].toUpperCase() : '?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: placeColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: placeColor.withValues(alpha: 0.15),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            border: Border.all(color: placeColor.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Text(
              LeaderboardStyleResolver.rankLabel(place),
              style: TextStyle(
                fontSize: 22,
                color: placeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
