class LeaderboardEntry {
  final int userId;
  final String username;
  final int score;
  final int quizzesAttempted;
  final int rank;

  const LeaderboardEntry({
    required this.userId,
    required this.username,
    required this.score,
    required this.quizzesAttempted,
    required this.rank,
  });
}
