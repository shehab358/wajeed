import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/features/auth/presentation/widgets/user_category.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  String? _selectedRole;
  Future<void> _saveRoleToSharedPreferences(String role) async {
    final sharedPreferences = serviceLocator.get<SharedPreferences>();
    await sharedPreferences.setString(SharedPrefKeys.role, role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Container(
            height: 600.h,
            width: 500.w,
            decoration: BoxDecoration(
              color: ColorManager.green,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Choose your role',
                  style: getBoldStyle(
                    color: ColorManager.white,
                  ).copyWith(
                    fontSize: 30.sp,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    UserCategory(
                      role: Strings.customer,
                      image: IconsAssets.customer,
                      isSelected: _selectedRole == Strings.customer,
                      onSelect: () {
                        setState(() {
                          _selectedRole = Strings.customer;
                        });
                      },
                    ),
                    UserCategory(
                      role: Strings.vendor,
                      image: IconsAssets.vendor,
                      isSelected: _selectedRole == Strings.vendor,
                      onSelect: () {
                        setState(() {
                          _selectedRole = Strings.vendor;
                        });
                      },
                    ),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomElevatedButton(
                    label: 'Next',
                    onTap: () {
                      _saveRoleToSharedPreferences(_selectedRole!);
                      if (_selectedRole != null) {
                        Navigator.pushNamed(
                          context,
                          Routes.register,
                        );
                      }
                    },
                  ),
                ),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
