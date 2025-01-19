import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_states.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vendor Screen',
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state is LogoutLoading) {
                  UIUtils.showLoading(context);
                } else if (state is LogoutError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is LogoutSuccess) {
                  log('logout success');
                  UIUtils.hideLoading(context);
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.login,
                  );
                  final sharedPref = serviceLocator.get<SharedPreferences>();
                  await sharedPref.setBool(SharedPrefKeys.isLogged, false);
                }
                log(SharedPrefKeys.isLogged);
              },
              child: CustomElevatedButton(
                label: 'Logout',
                onTap: () {
                  serviceLocator.get<AuthCubit>().logout();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
