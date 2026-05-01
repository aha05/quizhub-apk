import 'package:quizhub/features/home/data/models/category_model.dart';
import 'package:quizhub/features/home/data/models/user_activity_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories();
  Future<UserActivityModel> fetchUserActivity();
}
