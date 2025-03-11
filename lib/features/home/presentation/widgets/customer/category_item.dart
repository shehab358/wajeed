import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String name;
  final String route;
  const CategoryItem(
      {super.key,
      required this.image,
      required this.name,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: ColorManager.transparent,
                image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              name,
              style: getMediumStyle(
                color: ColorManager.black,
              ).copyWith(
                fontSize: FontSize.s18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
