import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';
import 'package:wajeed/features/product/presentation/cubit/product_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/product_states.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.s14),
              child: imageFile != null
                  ? Image.file(
                      widget.product.imageFile!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      IconsAssets.fastfood,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                ),
                Text(
                  widget.product.category,
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s12,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  widget.product.barcode.toString(),
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s10,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocListener<ProductCubit, ProductState>(
                  listener: (context, state) {
                    if (state is ProductDeleteLoading) {
                      UIUtils.showLoading(context);
                    } else if (state is ProductDeleteError) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.message);
                    } else if (state is ProductDeleteSuccess) {
                      UIUtils.hideLoading(context);
                      serviceLocator.get<ProductCubit>().fetchProducts();
                      Navigator.pop(context);
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      UIUtils.showDeleteWarning(context, () {
                        serviceLocator.get<ProductCubit>().deleteProduct(
                              widget.product.name,
                            );
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: ColorManager.error,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  widget.product.price.toString(),
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s12,
                  ),
                ),
                Spacer(),
                Text(
                  widget.product.discount.toString(),
                  style: getTextWithLine(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
