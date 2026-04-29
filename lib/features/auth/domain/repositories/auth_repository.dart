import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, User>> currentUser();
}
