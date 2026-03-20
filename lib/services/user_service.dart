import './api.dart';
import '../model/user_model.dart';

class UserService {
  final Api api;
  UserService(this.api);

  Future<void> changePassword(int userId, String oldPassword, String newPassword) async {
     await api.post("/users/${userId}/change-password", {'oldPassword': oldPassword, 'newPassword': newPassword});    
  }

    Future<User> updateProfile(String name, String email) async {
        final data = await api.put("/users/update/profile", {'name': name, 'email': email});
        return User.fromJson(data);
    }
}