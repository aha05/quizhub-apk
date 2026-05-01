abstract interface class TokenManager {
  Future<String?> getAccessToken();

  Future<void> saveAccessToken({required String accessToken});

  Future<void> clearTokens();
}
