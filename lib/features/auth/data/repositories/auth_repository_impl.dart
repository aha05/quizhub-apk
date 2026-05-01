import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/core/error/api_error_mapper.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/exceptions/api_exception.dart';
import 'package:quizhub/core/network/connection_checker.dart';
import 'package:quizhub/core/storage/token_manager.dart';
import 'package:quizhub/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:quizhub/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ConnectionChecker connectionChecker;
  final AuthRemoteDataSource remote;
  final TokenManager tokenManager;

  const AuthRepositoryImpl(
    this.connectionChecker,
    this.remote,
    this.tokenManager,
  );

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      await remote.logout();
      await tokenManager.clearTokens();
      return const Right(unit);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection'));
      }

      final user = await remote.currentUser();
      return right(user);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  }) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      final token = await remote.login(email: email, password: password);

      await tokenManager.saveAccessToken(accessToken: token.access);

      return const Right(unit);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection'));
    }

    try {
      final user = await remote.signUp(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on ApiException catch (e) {
      return Left(Failure(ApiErrorMapper.message(e.statusCode)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
