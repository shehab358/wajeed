import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.s14),
              child: Image.asset(
                ImageAssets.meal,
                height: 75.h,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Spansh Ricotta Pizza',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                ),
                Text(
                  'Pizza and doughs',
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s12,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Barcode : 1234567890',
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s10,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showWarning(context);
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: ColorManager.error,
                  ),
                ),
                Spacer(),
                Text(
                  'SAR 49.99',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s12,
                  ),
                ),
                Spacer(),
                Text(
                  'SAR 49.99',
                  style: getTextWithLine(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showWarning(BuildContext context) => showDialog(
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
                        onTap: () {},
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
