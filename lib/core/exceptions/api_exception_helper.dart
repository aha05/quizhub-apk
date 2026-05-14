import 'package:dio/dio.dart';
import 'package:quizhub/core/exceptions/api_exception.dart';

class ApiExceptionHelper {
  static ApiException fromDioException(DioException e) {
    final data = e.response?.data;

    return ApiException(
      message: _messageFromData(data),
      statusCode: e.response?.statusCode,
      body: data is Map<String, dynamic> ? data : null,
    );
  }

  static String _messageFromData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? 'Request failed';
    }

    return 'Request failed';
  }
}
