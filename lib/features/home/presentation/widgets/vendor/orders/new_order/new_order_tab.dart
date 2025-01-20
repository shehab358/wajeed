import 'package:flutter/material.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order.dart';

class NewOrderTab extends StatelessWidget {
  const NewOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Order(
            isPreparing: false,
            prepare: '3 mins ago',
            buttonText: 'View Order',
            buttonColor: ColorManager.black,
            buttonTextColor: ColorManager.white,
          );
        },
      ),
    );
  }
}
