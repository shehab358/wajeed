import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/features/home/presentation/cubit/basket_cubit.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';
import 'package:wajeed/features/product/presentation/cubit/delete_product_cubit/delete_product_cubit.dart';

class StoreProductItem extends StatefulWidget {
  final Product product;
  final String storeId;
  final String ownerId;
  const StoreProductItem(this.product,
      {super.key, required this.storeId, required this.ownerId});

  @override
  State<StoreProductItem> createState() => _StoreProductItemState();
}

class _StoreProductItemState extends State<StoreProductItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      fontSize: FontSize.s20,
                    ),
                  ),
                  Text(
                    widget.product.category.name,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    widget.product.price.toString(),
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.read<BasketCubit>().addProductToBasket(
                        product: widget.product,
                        storeId: widget.storeId,
                        ownerId: widget.ownerId,
                      );
                },
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  margin: EdgeInsets.all(Insets.s16),
                  decoration: BoxDecoration(
                    color: ColorManager.black,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.add,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
