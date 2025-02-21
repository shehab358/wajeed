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
import 'package:wajeed/features/product/presentation/cubit/delete_product_cubit/delete_product_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/delete_product_cubit/delete_product_states.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  const ProductItem(this.product, {super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final StoreGetCubit _storeGetCubit = serviceLocator.get<StoreGetCubit>();
  File? imageFile;
  @override
  void initState() {
    super.initState();
    _storeGetCubit.getStore();
  }

  @override
  Widget build(BuildContext context) {
    final storeId = _storeGetCubit.userStore?.id;
    return SizedBox(
      height: 100.h,
      child: BlocProvider(
        create: (context) => serviceLocator.get<DeleteProductCubit>(),
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(Insets.s14),
                child: Image.asset(
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
                    widget.product.category.name,
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
                  BlocListener<DeleteProductCubit, DeleteProductStates>(
                    listener: (context, state) {
                      if (state is ProductDeleteLoading) {
                        UIUtils.showLoading(context);
                      } else if (state is ProductDeleteError) {
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      } else if (state is ProductDeleteSuccess) {
                        UIUtils.hideLoading(context);
                      }
                    },
                    child: IconButton(
                      onPressed: () {
                        UIUtils.showDeleteWarning(context, () {
                          serviceLocator
                              .get<DeleteProductCubit>()
                              .deleteProduct(
                                widget.product.name,
                                widget.product.category.id,
                                storeId!,
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
      ),
    );
  }
}
