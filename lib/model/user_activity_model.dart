class UserActivity {
  final String name;
  final String level;
  final int totalQuizzes;
  final int completed;
  final List<String> badges;
  final double highestScorePercentage;
  final int leaderboard;
  final double averageScore;

  UserActivity({
    required this.name,
    required this.level,
    required this.totalQuizzes,
    required this.completed,
    required this.badges,
    required this.highestScorePercentage,
    required this.leaderboard,
    required this.averageScore,
  });

 factory UserActivity.fromJson(Map<String, dynamic> json) {
  return UserActivity(
    name: json['name'] as String? ?? '',
    level: json['level']as String? ?? '',
    totalQuizzes: json['totalQuizzes'] as int? ?? 0,
    completed: json['completed'] as int? ?? 0,
    badges: json['badges'] != null 
        ? List<String>.from(json['badges'] as List<dynamic>) 
        : [],
    highestScorePercentage: json['highestScorePercentage'] != null
        ? (json['highestScorePercentage'] as num).toDouble()
        : 0.0,
    leaderboard: json['leaderboard'] as int? ?? 0,
    averageScore: json['averageScore'] != null
        ? (json['averageScore'] as num).toDouble()
        : 0.0,
  );
}
}