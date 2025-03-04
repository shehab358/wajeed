import 'package:flutter/material.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/features/auth/presentation/screens/forget_password.dart';
import 'package:wajeed/features/auth/presentation/screens/login_screen.dart';
import 'package:wajeed/features/auth/presentation/screens/privacy_policy.dart';
import 'package:wajeed/features/auth/presentation/screens/register_screen.dart';
import 'package:wajeed/features/auth/presentation/screens/select_screen.dart';
import 'package:wajeed/features/home/presentation/screens/customer/basket_tab.dart';
import 'package:wajeed/features/home/presentation/screens/customer/store.dart';
import 'package:wajeed/features/store/presentation/screens/availability.dart';
import 'package:wajeed/features/store/presentation/screens/create_store.dart';
import 'package:wajeed/features/store/presentation/screens/rating_screen.dart';
import 'package:wajeed/features/home/presentation/screens/vendor/vendor_screen.dart';
import 'package:wajeed/features/home/presentation/screens/walkthrough.dart';
import 'package:wajeed/features/home/presentation/screens/customer/home_screen.dart';
import 'package:wajeed/features/store/presentation/screens/store_settings.dart';

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
      case Routes.select:
        return MaterialPageRoute(
          builder: (_) => SelectScreen(),
          settings: settings,
        );
      case Routes.vhome:
        return MaterialPageRoute(
          builder: (_) => VendorScreen(),
          settings: settings,
        );
      case Routes.storeSettings:
        return MaterialPageRoute(
          builder: (_) => StoreSettings(),
          settings: settings,
        );
      case Routes.availability:
        return MaterialPageRoute(
          builder: (_) => AvailabilityPage(),
          settings: settings,
        );
      case Routes.rating:
        return MaterialPageRoute(
          builder: (_) => RatingScreen(),
          settings: settings,
        );
      case Routes.createStore:
        return MaterialPageRoute(
          builder: (_) => CreateStore(),
          settings: settings,
        );
      case Routes.store:
        return MaterialPageRoute(
          builder: (_) => CustomerStore(),
          settings: settings,
        );
      case Routes.basket:
        return MaterialPageRoute(
          builder: (_) => BasketTab(),
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
