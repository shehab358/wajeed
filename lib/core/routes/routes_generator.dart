import 'package:flutter/material.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/features/home/presentation/screens/walkthrough.dart';
import 'package:wajeed/features/home/presentation/screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.walkthorough:
        return MaterialPageRoute(
          builder: (_) => const Walkthrough(),
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
