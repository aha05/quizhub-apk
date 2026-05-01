import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';

abstract interface class LeaderboardRepository {
  Future<Either<Failure, List<LeaderboardEntry>>> fetchLeaderboard();
}
