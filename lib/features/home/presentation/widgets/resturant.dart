import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';

class Resturant extends StatelessWidget {
  const Resturant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              ImageAssets.mcdonalds,
              height: 70.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'McDonalds',
                  style: getBoldStyle(
                    color: ColorManager.black,
                  ).copyWith(
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(
                  'Fast Food',
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ).copyWith(
                    fontSize: FontSize.s16,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Insets.s8),
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: ColorManager.lightpurple,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: ColorManager.starRate,
                          ),
                          Text(
                            '4.5',
                            style: getMediumStyle(color: ColorManager.starRate)
                                .copyWith(fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Insets.s8),
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: ColorManager.lightpurple,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            IconsAssets.delivery,
                            height: 18.h,
                            color: ColorManager.starRate,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'EGP 14.99',
                            style: getMediumStyle(color: ColorManager.starRate)
                                .copyWith(fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: getRegularStyle(
                  color: ColorManager.starRate,
                ).copyWith(
                  fontSize: FontSize.s16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 170.h,
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: AssetImage(
                          ImageAssets.meal,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    'Pizza medium',
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ).copyWith(
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    'SAR 20.00',
                    style: getMediumStyle(
                      color: ColorManager.starRate,
                    ).copyWith(
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    'SAR 20.00',
                    style: getTextWithLine().copyWith(
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
            ),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
          ),
        ),
      ],
    );
  }
}
