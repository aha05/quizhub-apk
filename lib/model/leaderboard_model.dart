class LeaderboardEntry {
  final int userId;
  final String username;
  final int score;
  final int quizzesAttempted;
  final int rank;

  LeaderboardEntry({
    required this.userId,
    required this.username,
    required this.score,
    required this.quizzesAttempted,
    required this.rank,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['userId'] as int? ?? 0,
      username: json['username'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      quizzesAttempted: json['quizzesAttempted'] as int? ?? 0,
      rank: json['rank'] as int? ?? 0,
    );
  }
}
