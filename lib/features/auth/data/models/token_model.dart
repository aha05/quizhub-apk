class TokenModel {
  final String access;

  TokenModel({required this.access});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    final access = json['token'] ?? json['access'];

    if (access == null) {
      throw FormatException('Access token missing from response');
    }

    return TokenModel(access: access);
  }
}
