import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:quizhub/features/auth/data/models/token_model.dart';
import 'package:quizhub/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<TokenModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
    );

    return TokenModel.fromJson(response.data);
  }

  @override
  Future<UserModel> currentUser() async {
    final response = await apiService.get(ApiEndpoints.currentUser);
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiEndpoints.singup,
      data: {"email": email, "password": password},
    );
    return UserModel.fromJson(response.data);
  }
}
