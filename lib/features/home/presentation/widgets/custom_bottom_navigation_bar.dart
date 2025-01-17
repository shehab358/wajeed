import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  final List<Map<String, dynamic>> _navItems = [
    {
      "icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "icon": Icons.percent,
      "label": "Sales",
    },
    {
      "icon": Icons.shopping_basket_outlined,
      "label": "Basket",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70.h,
        margin: EdgeInsets.all(
          Insets.s24,
        ),
        padding: EdgeInsets.all(
          Insets.s12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.r,
          ),
          color: ColorManager.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _navItems.length,
            (index) {
              final item = _navItems[index];
              final isSelected = index == widget.currentIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                   widget.onTabSelected(index);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'],
                      color: isSelected ? ColorManager.primary : Colors.grey,
                    ),
                    SizedBox(height: 0.h),
                    Text(
                      item['label'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isSelected ? ColorManager.primary : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
