import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/profile/domain/repositories/profile_repository.dart';

class ChangePassword implements UseCase<Unit, ChangePasswordParams> {
  final ProfileRepository profileRepository;

  const ChangePassword(this.profileRepository);

  @override
  Future<Either<Failure, Unit>> call(ChangePasswordParams params) {
    return profileRepository.changePassword(
      userId: params.userId,
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}

class ChangePasswordParams {
  final int userId;
  final String currentPassword;
  final String newPassword;

  const ChangePasswordParams({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
  });
}
