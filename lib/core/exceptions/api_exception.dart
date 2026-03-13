class ApiException implements Exception {
  final int statusCode;
  final Map<String, dynamic>? body;

  ApiException(this.statusCode, {this.body});

  @override
  String toString() {
    return "ApiException(statusCode: $statusCode, body: $body)";
  }
}