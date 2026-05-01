import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../services/api.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository(Api());

  User? _user;

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> loadUser() async {
    _user = await _authRepository.authUser();
    notifyListeners();
  }
}
