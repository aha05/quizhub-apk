import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/features/profile/domain/entities/profile_activity.dart';
import 'package:quizhub/features/profile/domain/entities/user_profile.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, ProfileActivity>> profileActivity();

  Future<Either<Failure, UserProfile>> updateProfile({
    required String name,
    required String email,
  });

  Future<Either<Failure, Unit>> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  });
}
