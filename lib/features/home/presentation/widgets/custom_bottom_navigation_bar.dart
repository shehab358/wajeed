import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/values_manager.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<NavItem> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.items,
    this.backgroundColor = Colors.black,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70.h,
        margin: EdgeInsets.all(Insets.s24),
        padding: EdgeInsets.all(Insets.s12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: widget.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            widget.items.length,
            (index) {
              final item = widget.items[index];
              final isSelected = index == widget.currentIndex;
              return GestureDetector(
                onTap: () => widget.onTabSelected(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.imageAsset != null)
                      Image.asset(
                        item.imageAsset!,
                        height: 24.h,
                        color: isSelected
                            ? widget.activeColor
                            : widget.inactiveColor,
                      )
                    else if (item.icon != null)
                      Icon(
                        item.icon,
                        color: isSelected
                            ? widget.activeColor
                            : widget.inactiveColor,
                      ),
                    SizedBox(height: 4.h),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isSelected
                            ? widget.activeColor
                            : widget.inactiveColor,
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

class NavItem {
  final IconData? icon;
  final String? imageAsset; // Path to the image asset
  final String label;

  NavItem({
    this.icon,
    this.imageAsset,
    required this.label,
  }) : assert(icon != null || imageAsset != null,
            'Either icon or imageAsset must be provided.');
}
