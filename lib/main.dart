import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/app_bloc_observer.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/firebase_options.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/routes/routes_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        initialRoute: Routes.login,
      ),
    );
  }
}
