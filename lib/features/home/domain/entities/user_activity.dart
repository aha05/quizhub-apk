class UserActivity {
  final String name;
  final String level;
  final int totalQuizzes;
  final int completed;
  final List<String> badges;
  final double highestScorePercentage;
  final int leaderboard;
  final double averageScore;

  const UserActivity({
    required this.name,
    required this.level,
    required this.totalQuizzes,
    required this.completed,
    required this.badges,
    required this.highestScorePercentage,
    required this.leaderboard,
    required this.averageScore,
  });
}
