import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order_history/history_order.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_cubit.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_states.dart';

class OrderHistoryTab extends StatelessWidget {
  final String storeId;
  const OrderHistoryTab({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.s16.w,
        vertical: Insets.s20.h,
      ),
      child: BlocBuilder<FetchStoreOrdersCubit, FetchStoreOrderStates>(
        builder: (context, state) {
          if (state is FetchStoreOrderCubitLoading) {
            return LoadingIndicator();
          } else if (state is FetchStoreOrderCubitError) {
            return ErrorIndicator(state.message);
          } else if (state is FetchStoreOrderCubitSuccess) {
            final finishedOrders = state.orders
                .where((order) => order.status == "Finished")
                .toList();

            return SingleChildScrollView(
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
                        '(${finishedOrders.length})',
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
                    height: 862.h,
                    child: ListView.builder(
                      itemCount: finishedOrders.length,
                      itemBuilder: (context, index) {
                        return HistoryOrder(
                          order: finishedOrders[index],
                          storeId: storeId,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
