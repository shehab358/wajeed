import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/new_order/new_order_tab.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/order_history/order_history_tab.dart';
import 'package:wajeed/features/home/presentation/widgets/vendor/orders/preparing_order/preparing_order_tab.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_cubit.dart';

class OrdersTab extends StatefulWidget {
  final String storeId;
  const OrdersTab({super.key, required this.storeId});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchStoreOrdersCubit>(context).fetchStoreOrders(
      widget.storeId,
    );

    _pageController = PageController();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Insets.s16.w,
            vertical: Insets.s16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Orders',
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s24,
                ),
              ),
              SizedBox(height: Insets.s16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab('New', 0),
                  _buildTab('Preparing', 1),
                  _buildTab('History', 2),
                ],
              ),
              SizedBox(height: Insets.s16.h),
              Expanded(
                child: PageView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: [
                    NewOrderTab(
                      storeId: widget.storeId,
                    ),
                    PreparingOrderTab(
                      storeId: widget.storeId,
                    ),
                    OrderHistoryTab(
                      storeId: widget.storeId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: _selectedIndex == index
                ? getBoldStyle(
                    color: ColorManager.starRate,
                    fontSize: FontSize.s16,
                  )
                : getMediumStyle(
                    color: ColorManager.grey,
                    fontSize: FontSize.s14,
                  ),
          ),
          if (_selectedIndex == index)
            Container(
              margin: EdgeInsets.only(top: 4.h),
              height: 2.h,
              width: 100.w,
              color: ColorManager.starRate,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
