import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/app_bloc_observer.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/routes/routes_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await configureDependncies();
  final sharedPref = serviceLocator.get<SharedPreferences>();
  final bool isWalkedthrough = sharedPref.getBool('isWalkedthrough') ?? false;
  final String initialRoute =
      isWalkedthrough ? Routes.home : Routes.walkthorough;
  runApp(
    WajedApp(
      initialRoute,
    ),
  );
}

class WajedApp extends StatelessWidget {
  final String initialRoute;
  const WajedApp(
    this.initialRoute, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
