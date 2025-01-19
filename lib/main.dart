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
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependncies();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPref = serviceLocator.get<SharedPreferences>();

  final bool isLogged = sharedPref.getBool('isLogged') ?? false;
  final String initialRoute = isLogged ? Routes.home : Routes.login;

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
    return BlocProvider(
      create: (_) => serviceLocator.get<AuthCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: initialRoute,
        ),
      ),
    );
  }
}
