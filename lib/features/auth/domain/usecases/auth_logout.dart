import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/auth/domain/repositories/auth_repository.dart';

class UserLogout implements UseCase<Unit, NoParams> {
  final AuthRepository authRepository;

  const UserLogout(this.authRepository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
