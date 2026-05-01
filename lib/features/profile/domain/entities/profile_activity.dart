class ProfileActivity {
  final String name;
  final String level;
  final int totalQuizzes;
  final int completed;
  final List<String> badges;
  final double highestScorePercentage;
  final int leaderboard;
  final double averageScore;

  const ProfileActivity({
    required this.name,
    required this.level,
    required this.totalQuizzes,
    required this.completed,
    required this.badges,
    required this.highestScorePercentage,
    required this.leaderboard,
    required this.averageScore,
  });

  ProfileActivity copyWith({
    String? name,
    String? level,
    int? totalQuizzes,
    int? completed,
    List<String>? badges,
    double? highestScorePercentage,
    int? leaderboard,
    double? averageScore,
  }) {
    return ProfileActivity(
      name: name ?? this.name,
      level: level ?? this.level,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      completed: completed ?? this.completed,
      badges: badges ?? this.badges,
      highestScorePercentage:
          highestScorePercentage ?? this.highestScorePercentage,
      leaderboard: leaderboard ?? this.leaderboard,
      averageScore: averageScore ?? this.averageScore,
    );
  }
}
