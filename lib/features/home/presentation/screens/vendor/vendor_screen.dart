import 'package:flutter/material.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:wajeed/features/category/presentation/screens/categories_tab.dart';
import 'package:wajeed/features/home/presentation/screens/vendor/my_shop/my_shop_tab.dart';
import 'package:wajeed/features/home/presentation/screens/vendor/orders/orders_tab.dart';
import 'package:wajeed/features/product/presentation/screens/products_tab.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const OrdersTab(),
    const CategoriesTab(),
    const ProductsTab(),
    const MyShopTab(),
  ];
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTabSelected: onTabSelected,
        activeColor: ColorManager.primary,
        backgroundColor: ColorManager.starRate,
        items: [
          NavItem(
            imageAsset: IconsAssets.orders,
            label: 'Orders',
          ),
          NavItem(
            imageAsset: IconsAssets.categories,
            label: 'categories',
          ),
          NavItem(
            icon: Icons.category_outlined,
            label: 'Products',
          ),
          NavItem(
            imageAsset: IconsAssets.store,
            label: 'My Shop',
          ),
        ],
      ),
      body: tabs[currentIndex],
    );
  }
}
