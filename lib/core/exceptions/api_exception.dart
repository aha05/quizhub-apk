class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? body;

  ApiException({required this.message, this.statusCode, this.body});

  @override
  String toString() => message;
}
