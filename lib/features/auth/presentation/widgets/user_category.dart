import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';

import '../../../../core/resources/styles_manager.dart';

class UserCategory extends StatelessWidget {
  final String role;
  final String image;
  final bool isSelected;
  final VoidCallback onSelect;

  const UserCategory({
    super.key,
    required this.role,
    required this.image,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: EdgeInsets.all(Insets.s20),
        height: 150.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 75.h,
            ),
            SizedBox(height: 20.h),
            Text(
              role,
              style: getBoldStyle(
                color: isSelected ? ColorManager.white : ColorManager.green,
              ).copyWith(
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
