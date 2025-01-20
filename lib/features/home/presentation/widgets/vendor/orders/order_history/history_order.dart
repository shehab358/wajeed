import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';

class HistoryOrder extends StatelessWidget {
  const HistoryOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270.h,
      width: double.infinity,
      child: Card(
        elevation: 2,
        color: ColorManager.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.s16.w,
            vertical: Insets.s16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Order ID: 123456',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 60.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: ColorManager.black,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: ColorManager.yellow,
                            size: 16.r,
                          ),
                          Text(
                            '4.0',
                            style: getMediumStyle(
                              color: ColorManager.yellow,
                            ).copyWith(fontSize: FontSize.s14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Insets.s5.h,
              ),
              Text(
                '24 Jun 2023 - 05:40 PM',
                style: getMediumStyle(
                  color: ColorManager.black,
                ).copyWith(
                  fontSize: FontSize.s12,
                ),
              ),
              SizedBox(
                height: Insets.s5.h,
              ),
              SizedBox(
                height: 60.h,
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(
                      Insets.s8,
                    ),
                    child: Image.asset(
                      ImageAssets.meal,
                    ),
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                ),
              ),
              Divider(
                color: ColorManager.grey,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    'SAR 200.00',
                    style: getBoldStyle(color: ColorManager.black)
                        .copyWith(fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SvgPicture.asset(
                        SvgAssets.credit,
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Credit Card',
                        style:
                            getMediumStyle(color: ColorManager.black).copyWith(
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: ColorManager.grey,
                thickness: 1,
              ),
              SizedBox(
                height: Insets.s16.h,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'view order',
                    ),
                    Icon(
                      Icons.arrow_forward_sharp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
