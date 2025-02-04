import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';

class StoreItem extends StatelessWidget {
  final Store store;
  const StoreItem(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: AssetImage(
                  ImageAssets.mcdonalds,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            store.name,
            style: getMediumStyle(
              color: ColorManager.black,
            ).copyWith(
              fontSize: FontSize.s18,
            ),
          ),
        ],
      ),
    );
  }
}
