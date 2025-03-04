import 'package:flutter/material.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/features/home/presentation/screens/customer/basket_tab.dart';
import 'package:wajeed/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:wajeed/features/home/presentation/screens/customer/home_tab.dart';
import 'package:wajeed/features/home/presentation/screens/customer/sales_tab.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  List<Widget> tabs = [
    const HomeTab(),
    const SalesTab(),
     BasketTab(),
  ];
  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTabSelected: onTabSelected,
        activeColor: ColorManager.yellow,
        backgroundColor: ColorManager.starRate,
        items: [
          NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
          ),
          NavItem(
            icon: Icons.percent,
            label: 'Sales',
          ),
          NavItem(
            icon: Icons.shopping_basket_outlined,
            label: 'Basket',
          ),
        ],
      ),
    );
  }
}
