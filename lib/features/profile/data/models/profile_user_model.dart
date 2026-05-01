import 'package:quizhub/features/profile/domain/entities/user_profile.dart';

class ProfileUserModel extends UserProfile {
  const ProfileUserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }
}
