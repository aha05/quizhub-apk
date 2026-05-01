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
    final token = await tokenManager.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, handler) async {
    if (err.response?.statusCode == 401 &&
        !_isRefreshing &&
        err.requestOptions.path != ApiEndpoints.refresh) {
      _isRefreshing = true;

      try {
        final response = await dio.post(ApiEndpoints.refresh);

        final newAccess = response.data['token'] ?? response.data['access'];

        if (newAccess == null) {
          throw DioException(
            requestOptions: err.requestOptions,
            error: 'Access token missing from refresh response',
          );
        }

        await tokenManager.saveAccessToken(accessToken: newAccess);

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

    handler.next(err);
  }
}
