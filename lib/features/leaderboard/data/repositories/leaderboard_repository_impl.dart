import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/api_error_mapper.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/exceptions/api_exception.dart';
import 'package:quizhub/core/network/connection_checker.dart';
import 'package:quizhub/features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'package:quizhub/features/leaderboard/domain/entities/leaderboard_entry.dart';
import 'package:quizhub/features/leaderboard/domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final ConnectionChecker connectionChecker;
  final LeaderboardRemoteDataSource remote;

  const LeaderboardRepositoryImpl(this.connectionChecker, this.remote);

  @override
  Future<Either<Failure, List<LeaderboardEntry>>> fetchLeaderboard() async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      return Right(await remote.fetchLeaderboard());
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
