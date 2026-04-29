import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/core/error/failures.dart';
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
    await tokenManager.clearTokens();
    return const Right(unit);
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final accessToken = await tokenManager.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        return Left(Failure('User is not authenticated'));
      }

      if (!await connectionChecker.isConnected) {
        return Left(Failure('No internet connection'));
      }

      final user = await remote.currentUser();
      return right(user);
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
      final tokens = await remote.login(email: email, password: password);

      await tokenManager.saveTokens(
        accessToken: tokens.access,
        refreshToken: tokens.refresh,
      );

      return const Right(unit);
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
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
