import './api.dart';
import '../../model/leaderboard_model.dart';

class LeaderboardService {
  final Api api;
  LeaderboardService(this.api);

  Future<List<LeaderboardEntry>> fetchLeaderboard() async {
  try {
    final dynamic response = await api.get("/user-activity/leaderboard");
    final List<dynamic> leaderboard = response as List<dynamic>;

    return leaderboard
        .map((json) => LeaderboardEntry.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to fetch leaderboard: $e');
  }
}

}