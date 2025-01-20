import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order_history/history_order.dart';

class OrderHistoryTab extends StatelessWidget {
  const OrderHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Insets.s16.w, vertical: Insets.s20.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Today's Orders",
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                  ),
                ),
                Spacer(),
                Text(
                  '(1)',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 320.h,
              child: ListView.builder(
                itemBuilder: (context, index) => HistoryOrder(),
                itemCount: 2,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Text(
                  "Older Orders",
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                ),
                Spacer(),
                Text(
                  '(200)',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 500.h,
              child: ListView.builder(
                  itemBuilder: (context, index) => HistoryOrder(),
                  itemCount: 5),
            ),
          ],
        ),
      ),
    );
  }
}
