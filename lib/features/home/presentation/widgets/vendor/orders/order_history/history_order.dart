import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order_bottom_sheet.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:intl/intl.dart';

class HistoryOrder extends StatelessWidget {
  final ORder order;
  final String storeId;
  const HistoryOrder({
    super.key,
    required this.order,
    required this.storeId,
  });

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
                  SingleChildScrollView(
                    child: Text(
                      'Order ID: ${order.orderId}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Insets.s5.h,
              ),
              Text(
                DateFormat.jm().format(order.createdAt.toDate()),
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
                    'SAR ${order.total}',
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
                onPressed: () {
                  _showFilter(context, order);
                },
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

  void _showFilter(BuildContext context, ORder order) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => OrderBottomSheet(
        order: order,
        storeId: storeId,
      ),
    );
  }
}
