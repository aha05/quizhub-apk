import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements UseCase<Unit, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, Unit>> call(UserLoginParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
