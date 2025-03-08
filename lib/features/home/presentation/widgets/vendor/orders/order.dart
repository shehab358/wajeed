import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/new_order/order_bottom_sheet.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';

class OrderItem extends StatelessWidget {
  final ORder order;
  const OrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = (order.createdAt).toDate();

    return SizedBox(
      height: 310.h,
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
                    order.orderId,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                        '$createdAt',
                        style: getMediumStyle(color: ColorManager.starRate)
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
                '${order.createdAt} ',
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
                    'SAR${order.total}',
                    style: getBoldStyle(color: ColorManager.black)
                        .copyWith(fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    order.products.length.toString() + ' items',
                    style: getMediumStyle(color: ColorManager.black).copyWith(
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Insets.s16.h,
              ),
              CustomElevatedButton(
                label: 'Mark as preparing',
                textStyle: getBoldStyle(color: ColorManager.black).copyWith(
                  fontSize: FontSize.s18,
                ),
                onTap: () {
                  // isPreparing ? () {} : _showFilter(context);
                },
                backgroundColor: ColorManager.black,
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
              )
            ],
          ),
        ),
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
