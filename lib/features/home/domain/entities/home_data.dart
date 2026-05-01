import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/home/domain/entities/user_activity.dart';

class HomeData {
  final List<Category> categories;
  final UserActivity userActivity;

  const HomeData({required this.categories, required this.userActivity});
}
