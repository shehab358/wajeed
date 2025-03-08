import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:wajeed/features/category/presentation/screens/categories_tab.dart';
import 'package:wajeed/features/store/presentation/screens/my_shop_tab.dart';
import 'package:wajeed/features/home/presentation/screens/vendor/orders/orders_tab.dart';
import 'package:wajeed/features/product/presentation/screens/products_tab.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_states.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  int currentIndex = 0;
  final StoreGetCubit _storeGetCubit = serviceLocator.get<StoreGetCubit>();

  @override
  void initState() {
    super.initState();
    _storeGetCubit.getStore();
  }

  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreGetCubit, StoreGetStates>(
      builder: (context, state) {
        if (state is StoreGetLoading) {
          return LoadingIndicator();
        } else if (state is StoreGetError) {
          return ErrorIndicator(state.message);
        } else if (state is StoreGetSuccess) {
          final store = state.store;

          List<Widget> tabs = [
            OrdersTab(
              storeId: store.id,
            ),
            CategoriesTab(
              storeId: store.id,
            ),
            ProductsTab(
              storeId: store.id,
            ),
            MyShopTab(
              store: store,
            ),
          ];

          return Scaffold(
            backgroundColor: ColorManager.white,
            bottomNavigationBar: GestureDetector(
              onTap: () => log(UserId.id),
              child: CustomBottomNavigationBar(
                currentIndex: currentIndex,
                onTabSelected: onTabSelected,
                activeColor: ColorManager.primary,
                backgroundColor: ColorManager.starRate,
                items: [
                  NavItem(imageAsset: IconsAssets.orders, label: 'Orders'),
                  NavItem(
                      imageAsset: IconsAssets.categories, label: 'Categories'),
                  NavItem(icon: Icons.category_outlined, label: 'Products'),
                  NavItem(imageAsset: IconsAssets.store, label: 'My Shop'),
                ],
              ),
            ),
            body: tabs[currentIndex],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
