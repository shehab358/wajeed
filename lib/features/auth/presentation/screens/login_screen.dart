import 'dart:developer';

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
import 'package:wajeed/core/utils/validator.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String countryCode = "+20";
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {});
    });

    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        ImageAssets.logo,
                        height: 200.h,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: 580.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorManager.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              topRight: Radius.circular(30.r),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Insets.s20.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  'phone number',
                                  style:
                                      getRegularStyle(color: ColorManager.white)
                                          .copyWith(
                                    fontSize: FontSize.s17,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        String? newCode =
                                            await showCountryCodePicker(
                                                context, countryCode);
                                        if (newCode != null) {
                                          setState(() {
                                            countryCode = newCode;
                                          });
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            height: 50.h,
                                            width: 65.w,
                                            decoration: BoxDecoration(
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Sizes.s8,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                countryCode,
                                                style: getSemiBoldStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: CustomTextField(
                                        textInputType: TextInputType.phone,
                                        validation:
                                            Validator.validatePhoneNumber,
                                        controller: _phoneController,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Text(
                                  'password',
                                  style:
                                      getRegularStyle(color: ColorManager.white)
                                          .copyWith(
                                    fontSize: FontSize.s17,
                                  ),
                                ),
                                CustomTextField(
                                  validation: Validator.validatePassword,
                                  isObscured: true,
                                  textInputType: TextInputType.text,
                                  controller: _passwordController,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.forgetPassword,
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Forgot Password?',
                                      style: getMediumStyle(
                                          color: ColorManager.primary,
                                          fontSize: FontSize.s17),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                BlocListener<AuthCubit, AuthState>(
                                  listener: (context, state) async {
                                    if (state is LoginLoading) {
                                      UIUtils.showLoading(context);
                                    } else if (state is LoginSuccess) {
                                      UIUtils.hideLoading(context);
                                      final bool isWalkedthrough =
                                          serviceLocator
                                                  .get<SharedPreferences>()
                                                  .getBool(
                                                    SharedPrefKeys
                                                        .isWalkedthrough,
                                                  ) ??
                                              false;
                                      final String? role =
                                          await SharedPrefHelper.getRole();

                                      if (isWalkedthrough) {
                                        if (role == Strings.customer) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            Routes.home,
                                          );
                                        } else if (role == Strings.vendor) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            Routes.vhome,
                                          );
                                        }
                                      } else {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          Routes.walkthorough,
                                        );
                                      }
                                      final sharedPref = serviceLocator
                                          .get<SharedPreferences>();
                                      await sharedPref.setBool(
                                          SharedPrefKeys.isLogged, true);
                                    } else if (state is LoginError) {
                                      UIUtils.hideLoading(context);

                                      UIUtils.showMessage(state.message);
                                      log(
                                        UserId.id,
                                      );
                                    }
                                  },
                                  child: CustomElevatedButton(
                                    label: 'Login',
                                    textStyle: getBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.s20),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        final phone =
                                            '$countryCode${_phoneController.text}';
                                        context.read<AuthCubit>().login(
                                              phone,
                                              _passwordController.text,
                                            );
                                        log(phone);
                                        log(_passwordController.text);
                                      }
                                    },
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: getRegularStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s17,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          Routes.select,
                                        );
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: getMediumStyle(
                                          color: ColorManager.primary,
                                          fontSize: FontSize.s17,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> showCountryCodePicker(
      BuildContext context, String currentCode) async {
    final List<Map<String, String>> countryCodes = [
      {"code": "+966", "name": "Saudi Arabia"},
      {"code": "+1", "name": "United States"},
      {"code": "+91", "name": "India"},
      {"code": "+44", "name": "United Kingdom"},
      {"code": "+81", "name": "Japan"},
      {"code": "+86", "name": "China"},
      {"code": "+49", "name": "Germany"},
      {"code": "+33", "name": "France"},
      {"code": "+971", "name": "United Arab Emirates"},
      {"code": "+61", "name": "Australia"},
      {"code": "+39", "name": "Italy"},
      {"code": "+55", "name": "Brazil"},
      {"code": "+7", "name": "Russia"},
      {"code": "+27", "name": "South Africa"},
      {"code": "+34", "name": "Spain"},
      {"code": "+20", "name": "Egypt"},
      {"code": "+234", "name": "Nigeria"},
      {"code": "+92", "name": "Pakistan"},
      {"code": "+62", "name": "Indonesia"},
      {"code": "+880", "name": "Bangladesh"},
      {"code": "+82", "name": "South Korea"},
      {"code": "+64", "name": "New Zealand"},
      {"code": "+46", "name": "Sweden"},
      {"code": "+31", "name": "Netherlands"},
      {"code": "+63", "name": "Philippines"},
    ];

    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Country Code"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: countryCodes.length,
              itemBuilder: (context, index) {
                final country = countryCodes[index];
                return ListTile(
                  title: Text("${country['code']} (${country['name']})"),
                  onTap: () => Navigator.of(context).pop(country['code']),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
