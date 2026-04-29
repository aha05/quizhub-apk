import 'package:dio/dio.dart';
import 'package:quizhub/core/constants/api_endpoints.dart';
import 'package:quizhub/core/storage/token_manager.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager tokenManager;
  final Dio dio;

  bool _isRefreshing = false;

  AuthInterceptor(this.tokenManager, this.dio);

  @override
  void onRequest(options, handler) async {
    print("new request!");

    final token = await tokenManager.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      final refreshToken = await tokenManager.getRefreshToken();

      if (refreshToken != null) {
        try {
          final response = await dio.post(
            ApiEndpoints.refresh,
            data: {"refresh": refreshToken},
          );

          final newAccess = response.data['access'];
          final newRefresh = response.data['refresh'];

          await tokenManager.saveTokens(
            accessToken: newAccess,
            refreshToken: newRefresh,
          );

          final request = err.requestOptions;
          request.headers['Authorization'] = 'Bearer $newAccess';

          final retryResponse = await dio.fetch(request);

          _isRefreshing = false;
          return handler.resolve(retryResponse);
        } catch (e) {
          _isRefreshing = false;
          await tokenManager.clearTokens();
        }
      }
    }

    handler.next(err);
  }
}
