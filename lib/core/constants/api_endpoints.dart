import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'http://localhost:8080';

  // ? auth
  static const login = '/auth/login';
  static const logout = '/auth/logout';
  static const refresh = '/auth/refresh';
  static const singup = '/auth/user';
  static const currentUser = '/auth/me';

  // ? home
  static const categories = '/quiz/category';
  static const userActivity = '/user-activity';
  static const leaderboard = '/user-activity/leaderboard';

  // ? profile
  static const updateProfile = '/users/update/profile';
  static String changePassword(int userId) => '/users/$userId/change-password';
}
