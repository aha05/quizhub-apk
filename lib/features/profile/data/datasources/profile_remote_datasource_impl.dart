import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/exceptions/api_exception_helper.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:quizhub/features/profile/data/models/profile_activity_model.dart';
import 'package:quizhub/features/profile/data/models/profile_user_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  const ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<ProfileActivityModel> fetchProfileActivity() async {
    try {
      final response = await apiService.get(ApiEndpoints.userActivity);
      return ProfileActivityModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }

  @override
  Future<ProfileUserModel> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      final response = await apiService.put(
        ApiEndpoints.updateProfile,
        data: {'name': name, 'email': email},
      );
      return ProfileUserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }

  @override
  Future<void> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await apiService.post(
        ApiEndpoints.changePassword(userId),
        data: {'oldPassword': currentPassword, 'newPassword': newPassword},
      );
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }
}
