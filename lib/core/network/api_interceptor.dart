import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('\n ➡️ REQUEST');
    print('URL: ${options.uri}');
    print('METHOD: ${options.method}');
    print('HEADERS: ${options.headers}');
    print('BODY: ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('\n ⬅️ RESPONSE');
    print('URL: ${response.requestOptions.uri}');
    print('STATUS: ${response.statusCode}');
    print('DATA: ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR');
    print('URL: ${err.requestOptions.uri}');
    print('MESSAGE: ${err.message}');
    print('RESPONSE: ${err.response?.data}');

    super.onError(err, handler);
  }
}
