import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/app_bloc_observer.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/firebase_options.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/routes/routes_generator.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/category_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependncies();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPref = serviceLocator.get<SharedPreferences>();

  final String initialRoute = determineInitialRoute(sharedPref);

  runApp(
    WajedApp(
      initialRoute,
    ),
  );
}

String determineInitialRoute(SharedPreferences sharedPref) {
  final bool isLogged = sharedPref.getBool(SharedPrefKeys.isLogged) ?? false;
  final bool isWalkThrough =
      sharedPref.getBool(SharedPrefKeys.isWalkedthrough) ?? false;

  if (!isWalkThrough) {
    return Routes.walkthorough;
  } else if (!isLogged) {
    return Routes.register;
  } else if (sharedPref.getString(SharedPrefKeys.role) == Strings.vendor) {
    return Routes.vhome;
  } else {
    return Routes.home;
  }
}

class WajedApp extends StatelessWidget {
  final String initialRoute;
  const WajedApp(
    this.initialRoute, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator.get<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator.get<CategoryCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.vhome,
        ),
      ),
    );
  }
}
