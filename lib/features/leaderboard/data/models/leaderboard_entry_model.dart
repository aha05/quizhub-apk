import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';

class LeaderboardEntryModel extends LeaderboardEntry {
  const LeaderboardEntryModel({
    required super.userId,
    required super.username,
    required super.score,
    required super.quizzesAttempted,
    required super.rank,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryModel(
      userId: json['userId'] as int? ?? 0,
      username: json['username'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      quizzesAttempted: json['quizzesAttempted'] as int? ?? 0,
      rank: json['rank'] as int? ?? 0,
    );
  }
}
