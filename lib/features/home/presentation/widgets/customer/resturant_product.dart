import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

class ResturantProduct extends StatelessWidget {
  final Product product;
  const ResturantProduct({
    super.key,
    required this.product,
  });

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
                  ImageAssets.meal,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            product.name,
            style: getMediumStyle(
              color: ColorManager.black,
            ).copyWith(
              fontSize: FontSize.s14,
            ),
          ),
          Text(
            'SAR ${product.price}',
            style: getMediumStyle(
              color: ColorManager.starRate,
            ).copyWith(
              fontSize: FontSize.s14,
            ),
          ),
          Text(
            'SAR ${product.discount}',
            style: getTextWithLine().copyWith(
              fontSize: FontSize.s12,
            ),
          ),
        ],
      ),
    );
  }
}
