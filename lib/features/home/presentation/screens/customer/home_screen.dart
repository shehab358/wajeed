import 'package:flutter/material.dart';
import 'package:wajeed/features/home/presentation/screens/customer/basket_tab.dart';
import 'package:wajeed/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:wajeed/features/home/presentation/screens/customer/home_tab.dart';
import 'package:wajeed/features/home/presentation/screens/customer/sales_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const SalesTab(),
    const BasketTab(),
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
