import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/exceptions/api_exception_helper.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/features/home/data/datasources/home_remote_datasource.dart';
import 'package:quizhub/features/home/data/models/category_model.dart';
import 'package:quizhub/features/home/data/models/user_activity_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  const HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await apiService.get(ApiEndpoints.categories);
      final categories = response.data as List<dynamic>;

      return categories
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }

  @override
  Future<UserActivityModel> fetchUserActivity() async {
    try {
      final response = await apiService.get(ApiEndpoints.userActivity);
      return UserActivityModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiExceptionHelper.fromDioException(e);
    }
  }
}
