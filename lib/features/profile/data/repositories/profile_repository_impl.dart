import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/api_error_mapper.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/exceptions/api_exception.dart';
import 'package:quizhub/core/network/connection_checker.dart';
import 'package:quizhub/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:quizhub/features/profile/domain/entities/profile_activity.dart';
import 'package:quizhub/features/profile/domain/entities/user_profile.dart';
import 'package:quizhub/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ConnectionChecker connectionChecker;
  final ProfileRemoteDataSource remote;

  const ProfileRepositoryImpl(this.connectionChecker, this.remote);

  @override
  Future<Either<Failure, ProfileActivity>> profileActivity() async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      return Right(await remote.fetchProfileActivity());
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfile({
    required String name,
    required String email,
  }) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      return Right(await remote.updateProfile(name: name, email: email));
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      await remote.changePassword(
        userId: userId,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return const Right(unit);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
