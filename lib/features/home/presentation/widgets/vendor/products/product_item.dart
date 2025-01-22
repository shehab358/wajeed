import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';

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
                    UIUtils.showDeleteWarning(context);
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
}
