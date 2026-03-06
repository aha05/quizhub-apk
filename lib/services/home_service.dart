import './api.dart';
import '../../model/category_model.dart';
import '../../model/user_activity_model.dart';

class HomeService {
  final Api api;
  HomeService(this.api);

  Future<List<Category>> fetchCategories() async {
  try {
    final dynamic response = await api.get("/quiz/category");
    final List<dynamic> categories = response as List<dynamic>;

    return categories
        .map((json) => Category.fromJson(json as Map<String, dynamic>))
        .toList();
  } catch (e) {
    throw Exception('Failed to fetch categories: $e');
  }
}

  Future<UserActivity> fetchUserActivity() async {
    final data = await api.get("/user-activity");

    return UserActivity.fromJson(data);
  }
}