import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/my_shop/rating.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        centerTitle: true,
        title: Text(
          'Rating',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
        ),
      ),
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.w,
            ),
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
              color: ColorManager.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100.w,
                ),
                Text(
                  '4.5',
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: Sizes.s40.sp,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.s16.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.star,
                              color: ColorManager.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: ColorManager.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: ColorManager.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: ColorManager.yellow,
                            ),
                            Icon(
                              Icons.star,
                              color: ColorManager.yellow,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        ' 827 Reviews',
                        style: getLightStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Rating(),
              itemCount: 6,
              separatorBuilder: (context, index) => Padding(
                padding:  EdgeInsets.symmetric(horizontal: Insets.s18.w),
                child: Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
