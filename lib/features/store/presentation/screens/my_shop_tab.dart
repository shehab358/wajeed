import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_states.dart';
import 'package:wajeed/features/store/presentation/cubit/store_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/store_states.dart';
import 'package:wajeed/features/store/presentation/widgets/shop_tab.dart';

class MyShopTab extends StatefulWidget {
  const MyShopTab({super.key});

  @override
  State<MyShopTab> createState() => _MyShopTabState();
}

class _MyShopTabState extends State<MyShopTab> {
  File? imageFile;
  final StoreCubit _storeCubit = serviceLocator.get<StoreCubit>();
  @override
  void initState() {
    super.initState();
    _storeCubit.getStore();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Insets.s16.w,
          vertical: Insets.s16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Store',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s20,
              ),
            ),
            SizedBox(height: Insets.s24.h),
            Row(
              children: [
                Container(
                  height: 80.h,
                  width: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          ImageAssets.user,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(width: Insets.s16.w),
                BlocBuilder<StoreCubit, StoreStates>(
                  builder: (context, state) {
                    if (state is StoreGetLoading) {
                      return LoadingIndicator();
                    } else if (state is StoreGetError) {
                      return ErrorIndicator(
                        state.message,
                      );
                    } else if (state is StoreGetSuccess) {
                      final store = state.store;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.name,
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          Text(
                            store.tagline,
                            style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        child: Text(
                          'No store found',
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: Sizes.s50.h,
            ),
            ShopTab(
              callBack: () {
                Navigator.pushNamed(
                  context,
                  Routes.storeSettings,
                );
              },
              icon: SvgAssets.shop,
              title: 'Store Settings',
            ),
            SizedBox(
              height: Insets.s16.h,
            ),
            ShopTab(
              callBack: () {
                Navigator.pushNamed(
                  context,
                  Routes.availability,
                );
              },
              icon: SvgAssets.shop,
              title: 'Availability',
            ),
            SizedBox(
              height: Insets.s16.h,
            ),
            ShopTab(
              callBack: () {
                Navigator.pushNamed(
                  context,
                  Routes.rating,
                );
              },
              icon: SvgAssets.rate,
              title: 'Rating',
            ),
            SizedBox(
              height: Insets.s16.h,
            ),
            ShopTab(
              callBack: () {},
              icon: SvgAssets.language,
              title: 'Language',
            ),
            SizedBox(
              height: Insets.s16.h,
            ),
            ShopTab(
              callBack: () {},
              icon: SvgAssets.contact,
              title: 'Contact Us',
              height: 30.h,
            ),
            SizedBox(
              height: Insets.s24.h,
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state is LogoutLoading) {
                  UIUtils.showLoading(context);
                } else if (state is LogoutError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(
                    state.message,
                  );
                } else if (state is LogoutSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.login,
                  );
                  final sharedPref = serviceLocator.get<SharedPreferences>();
                  await sharedPref.setBool(
                    SharedPrefKeys.isLogged,
                    false,
                  );
                }
              },
              child: InkWell(
                onTap: () {
                  serviceLocator.get<AuthCubit>().logout();
                  log(UserId.id);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: ColorManager.error,
                    ),
                    Text(
                      'Logout',
                      style: getMediumStyle(
                        color: ColorManager.error,
                      ).copyWith(
                        fontSize: FontSize.s18,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
