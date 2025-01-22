import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(
            horizontal: Insets.s16.w, vertical: Insets.s18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.r,
          ),
          color: ColorManager.white,
        ),
        child: Row(
          children: [
            Text(
              'Category Name',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                UIUtils.showDeleteWarning(context);
              },
              icon: Icon(
                Icons.delete_outline_rounded,
                color: ColorManager.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
