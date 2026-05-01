import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';
import 'package:quizhub/features/leaderboard/domain/repositories/leaderboard_repository.dart';

class FetchLeaderboard implements UseCase<List<LeaderboardEntry>, NoParams> {
  final LeaderboardRepository leaderboardRepository;

  const FetchLeaderboard(this.leaderboardRepository);

  @override
  Future<Either<Failure, List<LeaderboardEntry>>> call(NoParams params) {
    return leaderboardRepository.fetchLeaderboard();
  }
}
