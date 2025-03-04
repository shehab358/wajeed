import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/features/home/presentation/cubit/basket_cubit.dart';
import 'package:wajeed/features/home/presentation/cubit/basket_states.dart';
import 'package:wajeed/features/orders/data/models/order_model.dart';
import 'package:wajeed/features/orders/presentation/cubit/create_oredr_cubit/create_order_cubit.dart';
import 'package:wajeed/features/orders/presentation/cubit/create_oredr_cubit/create_order_states.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

class BasketTab extends StatefulWidget {
  const BasketTab({super.key});

  @override
  State<BasketTab> createState() => _BasketTabState();
}

class _BasketTabState extends State<BasketTab> {
  final CreateOrderCubit _createOrderCubit =
      serviceLocator.get<CreateOrderCubit>();
  final BasketCubit _basketCubit = serviceLocator.get<BasketCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        double totalPrice = 0.0;

        if (state is BasketUpdated) {
          totalPrice =
              state.basketItems.fold(0.0, (sum, item) => sum + item.price);
        }
        if (state is BasketUpdated && state.basketItems.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.basketItems.length,
                  itemBuilder: (context, index) {
                    Product product = state.basketItems[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text("SAR ${product.price}"),
                    );
                  },
                ),
              ),
              BlocListener<CreateOrderCubit, CreateOrderStates>(
                bloc: _createOrderCubit,
                listener: (context, state) {
                  if (state is CreateOrderCubitLoading) {
                    UIUtils.showLoading(context);
                  } else if (state is CreateOrderCubitError) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(state.message);
                  } else if (state is CreateOrderCubitSuccess) {}
                },
                child: ElevatedButton(
                  onPressed: () {
                    _createOrderCubit.createOrder(
                      OrderModel(
                        products: _basketCubit.basketProducts,
                        total: totalPrice,
                        createdAt: Timestamp.fromDate(DateTime.now()),
                        customerId: UserId.id,
                        storeId: _basketCubit.storeId,
                      ),
                      _basketCubit.storeId,
                      _basketCubit.ownerId,
                    );
                    log(
                      _basketCubit.ownerId,
                    );
                  },
                  child: Text("Checkout"),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text("Basket is empty"),
          );
        }
      },
    );
  }
}
