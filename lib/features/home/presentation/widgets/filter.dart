import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final List<bool> _isChecked = [false, false, false];
  List<String> sortList = [
    'Price: Low to High',
    'Price: High to Low',
    'Recommended',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 22.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: ColorManager.grey.withOpacity(0.2),
                    radius: 20.r,
                    child: Icon(Icons.close, color: ColorManager.black),
                  ),
                ),
                Text(
                  'Filter',
                  style: getBoldStyle(
                    color: ColorManager.black,
                  ).copyWith(
                    fontSize: FontSize.s20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isChecked.fillRange(0, _isChecked.length, false);
                    });
                  },
                  child: Text(
                    'Reset',
                    style: getMediumStyle(
                      color: ColorManager.error,
                    ).copyWith(
                      fontSize: FontSize.s18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              'Sort By',
              style: getBoldStyle(
                color: ColorManager.black,
              ).copyWith(
                fontSize: FontSize.s20,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 150.h,
                child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      sortList[index],
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ),
                    trailing: Checkbox(
                      value: _isChecked[index],
                      onChanged: (value) {
                        setState(() {
                          _isChecked[index] = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      activeColor: ColorManager.black,
                    ),
                    onTap: () {},
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
