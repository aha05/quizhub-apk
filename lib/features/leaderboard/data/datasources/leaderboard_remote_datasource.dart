import 'package:quizhub/features/leaderboard/data/models/leaderboard_entry_model.dart';

abstract interface class LeaderboardRemoteDataSource {
  Future<List<LeaderboardEntryModel>> fetchLeaderboard();
}
