import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/profile/domain/entities/user_profile.dart';
import 'package:quizhub/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfile implements UseCase<UserProfile, UpdateProfileParams> {
  final ProfileRepository profileRepository;

  const UpdateProfile(this.profileRepository);

  @override
  Future<Either<Failure, UserProfile>> call(UpdateProfileParams params) {
    return profileRepository.updateProfile(
      name: params.name,
      email: params.email,
    );
  }
}

class UpdateProfileParams {
  final String name;
  final String email;

  const UpdateProfileParams({required this.name, required this.email});
}
