import 'package:quizhub/features/home/domain/entities/user_activity.dart';

class UserActivityModel extends UserActivity {
  const UserActivityModel({
    required super.name,
    required super.level,
    required super.totalQuizzes,
    required super.completed,
    required super.badges,
    required super.highestScorePercentage,
    required super.leaderboard,
    required super.averageScore,
  });

  factory UserActivityModel.fromJson(Map<String, dynamic> json) {
    return UserActivityModel(
      name: json['name'] as String? ?? '',
      level: json['level'] as String? ?? '',
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
