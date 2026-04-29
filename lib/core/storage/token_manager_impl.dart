import 'package:quizhub/core/storage/secure_storage.dart';
import 'package:quizhub/core/storage/token_manager.dart';

class TokenManagerImpl implements TokenManager {
  final SecureStorage storage;

  TokenManagerImpl(this.storage);

  static const _accessKey = 'ACCESS_TOKEN';
  static const _refreshKey = 'REFRESH_TOKEN';

  @override
  Future<String?> getAccessToken() => storage.read(_accessKey);

  @override
  Future<String?> getRefreshToken() => storage.read(_refreshKey);

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await storage.write(_accessKey, accessToken);
    await storage.write(_refreshKey, refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await storage.delete(_accessKey);
    await storage.delete(_refreshKey);
  }
}