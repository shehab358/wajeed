import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';

class UIUtils {
  static void showLoading(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingIndicator(),
                ],
              ),
            ),
          ),
        ),
      );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
      );
  static void showDeleteWarning(
    BuildContext context,
    final void Function() onTap,
  ) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 166, 161),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: ColorManager.error,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Are you sure you want to delete this item?',
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomElevatedButton(
                        label: 'Yes, I\'m sure',
                        onTap: () {
                          onTap();
                          Navigator.pop(context);
                        },
                        backgroundColor: ColorManager.black,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: getSemiBoldStyle(
                            color: ColorManager.error,
                            fontSize: FontSize.s18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
