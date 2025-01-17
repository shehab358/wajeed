import 'package:flutter/material.dart';
import 'package:wajeed/features/home/presentation/widgets/basket_tab.dart';
import 'package:wajeed/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:wajeed/features/home/presentation/widgets/home_tab.dart';
import 'package:wajeed/features/home/presentation/widgets/sales_tab.dart';

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
      ),
    );
  }
}
