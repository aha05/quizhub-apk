import 'package:quizhub/features/profile/data/models/profile_activity_model.dart';
import 'package:quizhub/features/profile/data/models/profile_user_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileActivityModel> fetchProfileActivity();

  Future<ProfileUserModel> updateProfile({
    required String name,
    required String email,
  });

  Future<void> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  });
}
