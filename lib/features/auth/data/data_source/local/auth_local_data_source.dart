abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String> getToken();
}
