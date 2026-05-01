import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/network/adapters/api_http_client_adapter.dart';
import 'package:quizhub/core/network/api_interceptor.dart';
import 'package:quizhub/core/network/auth_interceptor.dart';
import 'package:quizhub/core/storage/token_manager.dart';

class ApiService {
  late final Dio dio;
  CookieJar? _cookieJar;

  CookieJar? get cookieJar => _cookieJar;

  ApiService(TokenManager tokenManager) {
    dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

    if (kIsWeb) {
      configureApiHttpClientAdapter(dio);
    } else {
      _cookieJar = CookieJar();
      dio.interceptors.add(CookieManager(_cookieJar!));
    }

    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(AuthInterceptor(tokenManager, dio));
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<void> clearCookies() async {
    await _cookieJar?.deleteAll();
  }
}
