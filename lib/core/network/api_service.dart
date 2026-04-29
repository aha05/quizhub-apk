import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/network/auth_interceptor.dart';
import 'package:quizhub/core/storage/token_manager.dart';

class ApiService {
  late final Dio dio;

  ApiService(TokenManager tokenManager) {
    dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
    dio.interceptors.add(AuthInterceptor(tokenManager, dio));
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }
}