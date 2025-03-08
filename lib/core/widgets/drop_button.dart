import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';

class CustomDropButton extends StatefulWidget {
  final void Function(String?) onCategorySelected;
  final List<dynamic> categories;
  final String hint;
  final String? selectedValue; // Add selectedValue parameter

  const CustomDropButton({
    super.key,
    required this.onCategorySelected,
    required this.categories,
    required this.hint,
    this.selectedValue,
  });

  @override
  State<CustomDropButton> createState() => _CustomDropButtonState();
}

class _CustomDropButtonState extends State<CustomDropButton> {
  String? selectedCategoryId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategoryId = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 2,
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.grey2,
          ),
        ),
      ),
      value: selectedCategoryId,
      hint: Text(
        widget.hint,
        style: getRegularStyle(
          color: ColorManager.grey2,
        ),
      ),
      items: widget.categories
          .map(
            (category) => DropdownMenuItem<String>(
              value: category.id,
              child: Row(
                children: [
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(category.name),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCategoryId = value;
        });
        widget.onCategorySelected(selectedCategoryId);
      },
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}
