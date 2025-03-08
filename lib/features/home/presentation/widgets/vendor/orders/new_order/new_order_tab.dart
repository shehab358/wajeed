import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_cubit.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_states.dart';

class NewOrderTab extends StatefulWidget {
  final String storeId;
  const NewOrderTab({super.key, required this.storeId});

  @override
  State<NewOrderTab> createState() => _NewOrderTabState();
}

class _NewOrderTabState extends State<NewOrderTab> {
  final FetchStoreOrdersCubit _fetchStoreOrdersCubit =
      serviceLocator.get<FetchStoreOrdersCubit>();

  @override
  void initState() {
    super.initState();
    _fetchStoreOrdersCubit.fetchStoreOrders(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchStoreOrdersCubit, FetchStoreOrderStates>(
      bloc: _fetchStoreOrdersCubit,
      builder: (context, state) {
        if (state is FetchStoreOrderCubitLoading) {
          return LoadingIndicator();
        } else if (state is FetchStoreOrderCubitError) {
          return ErrorIndicator(state.message);
        } else if (state is FetchStoreOrderCubitSuccess) {
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              return OrderItem(order: state.orders[index]);
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
