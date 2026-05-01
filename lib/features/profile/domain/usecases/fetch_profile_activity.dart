import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/profile/domain/entities/profile_activity.dart';
import 'package:quizhub/features/profile/domain/repositories/profile_repository.dart';

class FetchProfileActivity implements UseCase<ProfileActivity, NoParams> {
  final ProfileRepository profileRepository;

  const FetchProfileActivity(this.profileRepository);

  @override
  Future<Either<Failure, ProfileActivity>> call(NoParams params) {
    return profileRepository.fetchProfileActivity();
  }
}
