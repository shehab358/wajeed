import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/purchased_item.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:intl/intl.dart';

class CustomerOrder extends StatelessWidget {
  final ORder order;
  const CustomerOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Insets.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order ID: ${order.orderId}',
                style: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Order From: ${order.storeName}',
                style: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Ordered At: ',
                    style: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.jm().format(order.createdAt.toDate()),
                    style: TextStyle(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'Order Status: ${order.status}',
                style: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  itemBuilder: (context, index) => PurchasedItem(
                    product: order.products[index],
                  ),
                  itemCount: order.products.length,
                ),
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'SAR ${order.total}',
                    style: getBoldStyle(
                      color: ColorManager.black,
                    ).copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}
