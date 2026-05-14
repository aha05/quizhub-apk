import 'package:quizhub/features/home/domain/entities/user_activity.dart';
import 'package:quizhub/features/home/presentation/widgets/temp-data/category.dart';

class HomeData {
  final List<Category> categories;
  final UserActivity userActivity;

  const HomeData({required this.categories, required this.userActivity});
}
