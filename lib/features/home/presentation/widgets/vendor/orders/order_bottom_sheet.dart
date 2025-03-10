import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/purchased_item.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:intl/intl.dart';
import 'package:wajeed/features/orders/presentation/cubit/cubit/update_order_cubit.dart';

class OrderBottomSheet extends StatefulWidget {
  final ORder order;
  final String storeId;
  const OrderBottomSheet(
      {super.key, required this.order, required this.storeId});

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
                    widget.order.orderId,
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
                DateFormat.jm().format(widget.order.createdAt.toDate()),
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
              Visibility(
                visible: widget.order.status == 'waiting' ? true : false,
                child: Text(
                  'set estimation for order preparation',
                  style: getRegularStyle(color: ColorManager.black).copyWith(
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
              Visibility(
                visible: widget.order.status == 'waiting' ? true : false,
                child: Row(
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
                  itemBuilder: (context, index) => PurchasedItem(
                    product: widget.order.products[index],
                  ),
                  itemCount: widget.order.products.length,
                ),
              ),
              Divider(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'SAR ${widget.order.total}',
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
              SizedBox(
                height: 15.h,
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
                child: Visibility(
                  visible: widget.order.status == 'waiting'
                      ? true
                      : widget.order.status == 'Preparing'
                          ? true
                          : false,
                  child: CustomElevatedButton(
                    textStyle: getBoldStyle(color: ColorManager.black).copyWith(
                      fontSize: FontSize.s18,
                    ),
                    label: widget.order.status == 'waiting'
                        ? 'Mark as Preparing'
                        : 'Mark as Finished',
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.order.status == 'waiting') {
                        serviceLocator.get<UpdateOrderCubit>().updateStore(
                              order: widget.order,
                              ownerId: UserId.id,
                              storeId: widget.storeId,
                              newStatus: 'Preparing',
                              newDuration: _timer,
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
                  ),
                ),
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
