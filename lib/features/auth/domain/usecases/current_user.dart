import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/features/auth/domain/repositories/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}