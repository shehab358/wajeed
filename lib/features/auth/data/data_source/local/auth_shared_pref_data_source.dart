import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/auth/data/data_source/local/auth_local_data_source.dart';

@Singleton(as: AuthLocalDataSource)
class AuthSharedPrefDataSource implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthSharedPrefDataSource(
    this._sharedPreferences,
  );

  @override
  Future<void> cacheToken(String token) {
    try {
      return _sharedPreferences.setString(ChacheConstants.token, token);
    } catch (e) {
      throw LocalException('Failed to cache token');
    }
  }

  @override
  Future<String> getToken() {
    try {
      final token = _sharedPreferences.getString(ChacheConstants.token);
      if (token != null) {
        return Future.value(token);
      } else {
        return Future.error('Token not found');
      }
    } catch (e) {
      throw LocalException('Failed to cache token');
    }
  }
}
