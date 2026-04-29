import 'package:quizhub/core/common/entities/user.dart';
import 'package:quizhub/features/auth/data/models/token_model.dart';
import 'package:quizhub/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<TokenModel> login({required String email, required String password});
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> currentUser();
}
