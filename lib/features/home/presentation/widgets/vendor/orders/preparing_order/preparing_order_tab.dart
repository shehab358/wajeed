import 'package:flutter/material.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order.dart';

class PreparingOrderTab extends StatelessWidget {
  const PreparingOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => Order(
        prepare: 'Preparing',
        buttonText: 'Mark as Ready',
        buttonColor: ColorManager.primary,
        buttonTextColor: ColorManager.black,
        isPreparing: true,
      ),
    );
  }
}
