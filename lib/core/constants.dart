import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/di/service_locator.dart';

class ChacheConstants {
  static const String token = 'token';
}

class SharedPrefKeys {
  static const String isLogged = 'isLogged';
  static const String role = 'role';
  static const String isWalkedthrough = 'isWalkedthrough';
}

class SharedPrefHelper {
  static Future<void> saveRole(String role) async {
    final SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    await prefs.setString(SharedPrefKeys.role, role);
  }

  static Future<String?> getRole() async {
    final SharedPreferences prefs = serviceLocator.get<SharedPreferences>();
    return prefs.getString(SharedPrefKeys.role);
  }
}

class Strings {
  static const String vendor = 'Vendor';
  static const String customer = 'Customer';
}
