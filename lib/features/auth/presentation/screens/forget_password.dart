import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/validator.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String countryCode = "+966";
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                      CustomElevatedButton(
                        label: 'Next',
                        textStyle: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s20),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {}
                        },
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
}
