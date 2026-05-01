import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/api_error_mapper.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/exceptions/api_exception.dart';
import 'package:quizhub/core/network/connection_checker.dart';
import 'package:quizhub/features/home/data/datasources/home_remote_datasource.dart';
import 'package:quizhub/features/home/domain/entities/home_data.dart';
import 'package:quizhub/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ConnectionChecker connectionChecker;
  final HomeRemoteDataSource remote;

  const HomeRepositoryImpl(this.connectionChecker, this.remote);

  @override
  Future<Either<Failure, HomeData>> fetchHomeData() async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      final categories = await remote.fetchCategories();
      final userActivity = await remote.fetchUserActivity();

      return Right(
        HomeData(categories: categories, userActivity: userActivity),
      );
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
