import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order_bottom_sheet.dart';

class NewOrderTab extends StatelessWidget {
  const NewOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 300.h,
            width: double.infinity,
            child: Card(
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
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          width: 90.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: ColorManager.lightpurple,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              '3 mins ago',
                              style:
                                  getMediumStyle(color: ColorManager.starRate)
                                      .copyWith(fontSize: FontSize.s14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Insets.s5.h,
                    ),
                    Text(
                      '05:40 PM',
                      style: getMediumStyle(color: ColorManager.black)
                          .copyWith(fontSize: FontSize.s12),
                    ),
                    SizedBox(
                      height: Insets.s5.h,
                    ),
                    SizedBox(
                      height: 60.h,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(Insets.s8),
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
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          'SAR 200.00',
                          style: getBoldStyle(color: ColorManager.black)
                              .copyWith(fontSize: FontSize.s16),
                        ),
                        Spacer(),
                        Text(
                          '4 items',
                          style: getMediumStyle(color: ColorManager.black)
                              .copyWith(
                            fontSize: FontSize.s12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Insets.s16.h,
                    ),
                    CustomElevatedButton(
                      label: 'View Order',
                      onTap: () {
                        _showFilter(context);
                      },
                      backgroundColor: ColorManager.black,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent, 

      context: context,
      isScrollControlled: true,
      builder: (context) => const OrderBottomSheet(),
    );
  }
}
