import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/purchased_item.dart';

class OrderBottomSheet extends StatefulWidget {
  const OrderBottomSheet({super.key});

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  int _timer = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Container(
          padding: EdgeInsets.all(Insets.s18),
          height: 110.h,
          decoration: BoxDecoration(
            color: ColorManager.starRate,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Order ID: 123456',
                    style: getBoldStyle(color: ColorManager.white).copyWith(
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                      size: 30.r,
                    ),
                  ),
                ],
              ),
              Text(
                '05:40 PM',
                style: getRegularStyle(color: ColorManager.white).copyWith(
                  fontSize: FontSize.s16,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 550.h,
          width: double.infinity,
          padding: EdgeInsets.all(Insets.s18),
          decoration: BoxDecoration(
            color: ColorManager.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'set estimation for order preparation',
                style: getRegularStyle(color: ColorManager.black).copyWith(
                  fontSize: FontSize.s16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _incrementTimer,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorManager.black,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Insets.s8.w),
                    height: 50.h,
                    width: 242.5.w,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: ColorManager.grey,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$_timer min',
                        style: getSemiBoldStyle(color: ColorManager.black)
                            .copyWith(
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrementTimer,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorManager.black,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 250.h,
                child: ListView.builder(
                  itemBuilder: (context, index) => PurchasedItem(),
                  itemCount: 5,
                ),
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'SAR 50.00',
                    style: getBoldStyle(color: ColorManager.black).copyWith(
                      fontSize: FontSize.s18,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SvgPicture.asset(
                        SvgAssets.cash,
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Cash',
                        style:
                            getMediumStyle(color: ColorManager.black).copyWith(
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomElevatedButton(
                textStyle: getBoldStyle(color: ColorManager.black).copyWith(
                  fontSize: FontSize.s18,
                ),
                label: 'Accept Order',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _incrementTimer() {
    setState(() {
      _timer += 5;
    });
  }

  void _decrementTimer() {
    if (_timer <= 0) {
      return;
    }
    setState(() {
      _timer -= 5;
    });
  }
}
