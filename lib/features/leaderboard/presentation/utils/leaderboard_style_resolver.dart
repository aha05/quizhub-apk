import 'package:flutter/material.dart';
import 'package:quizhub/features/leaderboard/presentation/utils/leaderboard_presentation_constants.dart';

class LeaderboardStyleResolver {
  const LeaderboardStyleResolver._();

  static Color podiumColor(int place) {
    switch (place) {
      case 1:
        return LeaderboardPresentationConstants.goldColor;
      case 2:
        return LeaderboardPresentationConstants.silverColor;
      case 3:
        return LeaderboardPresentationConstants.bronzeColor;
      default:
        return Colors.grey;
    }
  }

  static String rankLabel(int rank) => rank <= 3 ? '$rank' : '#$rank';

  static Color avatarBackgroundColor(int rank) {
    switch (rank) {
      case 1:
        return LeaderboardPresentationConstants.goldSurfaceColor;
      case 2:
        return LeaderboardPresentationConstants.silverSurfaceColor;
      case 3:
        return LeaderboardPresentationConstants.bronzeSurfaceColor;
      default:
        return const Color(0xFFEEF2FF);
    }
  }

  static Color avatarTextColor(int rank) {
    switch (rank) {
      case 1:
        return LeaderboardPresentationConstants.goldTextColor;
      case 2:
        return LeaderboardPresentationConstants.silverTextColor;
      case 3:
        return LeaderboardPresentationConstants.bronzeTextColor;
      default:
        return LeaderboardPresentationConstants.primaryColor;
    }
  }
}
