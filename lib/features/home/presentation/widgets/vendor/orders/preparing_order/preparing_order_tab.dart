import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_cubit.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_states.dart';

class PreparingOrderTab extends StatefulWidget {
  final String storeId;
  const PreparingOrderTab({
    super.key,
    required this.storeId,
  });

  @override
  State<PreparingOrderTab> createState() => _PreparingOrderTabState();
}

class _PreparingOrderTabState extends State<PreparingOrderTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchStoreOrdersCubit, FetchStoreOrderStates>(
      builder: (context, state) {
        if (state is FetchStoreOrderCubitLoading) {
          return LoadingIndicator();
        } else if (state is FetchStoreOrderCubitError) {
          return ErrorIndicator(state.message);
        } else if (state is FetchStoreOrderCubitSuccess) {
          final waitingOrders = state.orders
              .where((order) => order.status == "Preparing")
              .toList();

          return ListView.builder(
            itemCount: waitingOrders.length,
            itemBuilder: (context, index) {
              return OrderItem(
                order: waitingOrders[index],
                storeId: widget.storeId,
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
