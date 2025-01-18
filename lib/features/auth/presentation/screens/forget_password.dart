import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/utils/validator.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_states.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String countryCode = "+20";
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final phone = ModalRoute.of(context)?.settings.arguments as String?;
      if (phone != null) {
        _phoneController.text = phone;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
        ),
        backgroundColor: ColorManager.white,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                ImageAssets.password,
                height: 200.h,
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                height: 500.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Insets.s20.w,
                    vertical: Insets.s20.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password',
                        style: getSemiBoldStyle(
                          color: ColorManager.white,
                          fontSize: Sizes.s28,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        '''Enter your phone number, we'll send you a code to reset your password''',
                        style: getMediumStyle(
                          color: ColorManager.white,
                          fontSize: Sizes.s20,
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        'phone number',
                        style:
                            getRegularStyle(color: ColorManager.white).copyWith(
                          fontSize: FontSize.s17,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              String? newCode = await showCountryCodePicker(
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
                                        BorderRadius.circular(Sizes.s8),
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
                              validation: Validator.validatePhoneNumber,
                              controller: _phoneController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is ResetPasswordLoading) {
                            UIUtils.showLoading(context);
                          } else if (state is ResetPasswordError) {
                            UIUtils.hideLoading(context);
                            UIUtils.showMessage(state.message);
                          } else if (state is ResetPasswordSuccess) {
                            UIUtils.hideLoading(context);
                            UIUtils.showMessage(
                              'Check your email to reset your password',
                            );
                          }
                        },
                        child: CustomElevatedButton(
                          label: 'Next',
                          textStyle: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s20),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().resetPassword(
                                    '$countryCode${_phoneController.text}',
                                  );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
