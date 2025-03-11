import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order_bottom_sheet.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:wajeed/features/orders/presentation/cubit/cubit/update_order_cubit.dart';

class OrderItem extends StatefulWidget {
  final ORder order;
  final String storeId;
  const OrderItem({
    super.key,
    required this.order,
    required this.storeId,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    DateTime createdAt = widget.order.createdAt.toDate();
    String timeAgo = timeago.format(createdAt);

    return SizedBox(
      height: 310.h,
      width: double.infinity,
      child: Card(
        elevation: 2,
        color: ColorManager.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.s8.w,
            vertical: Insets.s16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.order.orderId,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Container(
                    width: 120.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: ColorManager.lightpurple,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        timeAgo,
                        style: getMediumStyle(color: ColorManager.starRate)
                            .copyWith(
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                  ),
                ],
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
                    'SAR${widget.order.total}',
                    style: getBoldStyle(color: ColorManager.black)
                        .copyWith(fontSize: FontSize.s16),
                  ),
                  Spacer(),
                  Text(
                    '${widget.order.products.length} items',
                    style: getMediumStyle(color: ColorManager.black).copyWith(
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Insets.s16.h,
              ),
              BlocListener<UpdateOrderCubit, UpdateOrderState>(
                listener: (context, state) {
                  if (state is UpdateOrderLoading) {
                    UIUtils.showLoading(context);
                  } else if (state is UpdateOrderError) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(state.message);
                  } else if (state is UpdateOrderSuccess) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage('Order updated successfully');
                  }
                },
                child: CustomElevatedButton(
                  label: widget.order.status == 'waiting' ? 'Mark as Preparing' : 'Mark as Finished',
                  textStyle: getBoldStyle(color: ColorManager.white).copyWith(
                    fontSize: FontSize.s18,
                  ),
                  onTap: () {
                    if (widget.order.status == 'waiting') {
                      serviceLocator.get<UpdateOrderCubit>().updateStore(
                            order: widget.order,
                            ownerId: UserId.id,
                            storeId: widget.storeId,
                            newStatus: 'Preparing',
                            newDuration: 20,
                          );
                    } else if (widget.order.status == 'Preparing') {
                      serviceLocator.get<UpdateOrderCubit>().updateStore(
                            order: widget.order,
                            ownerId: UserId.id,
                            storeId: widget.storeId,
                            newStatus: 'Finished',
                          );
                    }
                  },
                  backgroundColor: ColorManager.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  _showOrderBottomSheet(context, widget.order);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View order',
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

  void _showOrderBottomSheet(BuildContext context, ORder order) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => OrderBottomSheet(
        order: order,
        storeId: widget.storeId,
      ),
    );
  }
}
