import 'package:flutter/material.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/features/auth/presentation/screens/forget_password.dart';
import 'package:wajeed/features/auth/presentation/screens/login_screen.dart';
import 'package:wajeed/features/auth/presentation/screens/privacy_policy.dart';
import 'package:wajeed/features/auth/presentation/screens/register_screen.dart';
import 'package:wajeed/features/home/presentation/screens/walkthrough.dart';
import 'package:wajeed/features/home/presentation/screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case Routes.walkthorough:
        return MaterialPageRoute(
          builder: (_) => const Walkthrough(),
          settings: settings,
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case Routes.privacy:
        return MaterialPageRoute(
          builder: (_) => PrivacyPolicyScreen(),
          settings: settings,
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPassword(),
          settings: settings,
        );


      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'No Route Found',
          ),
        ),
        body: const Center(
          child: Text(
            'No Route Found',
          ),
        ),
      ),
    );
  }
}
