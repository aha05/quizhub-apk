import 'package:quizhub/core/storage/secure_storage.dart';
import 'package:quizhub/core/storage/token_manager.dart';

class TokenManagerImpl implements TokenManager {
  final SecureStorage storage;

  TokenManagerImpl(this.storage);

  static const _accessKey = 'ACCESS_TOKEN';

  @override
  Future<String?> getAccessToken() => storage.read(_accessKey);

  @override
  Future<void> saveAccessToken({required String accessToken}) async {
    await storage.write(_accessKey, accessToken);
  }

  @override
  Future<void> clearTokens() async {
    await storage.delete(_accessKey);
  }
}
