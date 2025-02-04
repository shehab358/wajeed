import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';

class ShopTab extends StatelessWidget {
  final VoidCallback callBack;
  final String icon;
  final String title;
  final double? height;

  const ShopTab({
    super.key,
    required this.callBack,
    required this.icon,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  height: height,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.black,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Divider(
            color: ColorManager.grey,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
