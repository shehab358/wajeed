import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';

class PurchasedItem extends StatelessWidget {
  const PurchasedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Image.asset(
            ImageAssets.meal,
            height: 40.h,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1X Pizza',
                style: getBoldStyle(
                    color: ColorManager.black, fontSize: FontSize.s16),
              ),
              Text(
                'Without added vegetables',
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: FontSize.s14),
              ),
            ],
          ),
          Spacer(),
          Text(
            'SAR 10.00',
            style:
                getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
          ),
        ],
      ),
    );
  }
}
