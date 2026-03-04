import 'package:shared_preferences/shared_preferences.dart';
import '../services/api.dart';

class AuthRepository {
  final Api api;
  AuthRepository(this.api);

  static const String TOKEN_KEY = "auth_token"; 

  // Login and save JWT
  Future<String> login(String email, String password) async {
    final res = await api.post('/auth/login', {'email': email, 'password': password});
    final token = res['token'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token); // save token locally

    return token;
  }


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
  }

  // Get stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  // Check if logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}