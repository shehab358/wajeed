import 'dart:developer';

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
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_states.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/presentation/cubit/add_product_cubit/add_product_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/add_product_cubit/add_product_states.dart';
import 'package:wajeed/features/product/presentation/widgets/category_drop_down_button.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart';

class AddProductWidget extends StatefulWidget {
  final String storeId;
  const AddProductWidget({super.key, required this.storeId});

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _priceBeforeController = TextEditingController();
  final AddProductCubit _productCubit = serviceLocator.get<AddProductCubit>();

  final StoreGetCubit _storeGetCubit = serviceLocator.get<StoreGetCubit>();
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: AssetImage(ImageAssets.food),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Add Image',
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                ),
              ),
              Text('Enter Product Name'),
              CustomTextField(
                hint: 'Product Name',
                controller: _productName,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Chose Category'),
              CategoryDropdown(
                onCategorySelected: (Category category) {
                  selectedCategory = category;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Enter Barcode'),
              CustomTextField(
                hint: 'Barcode',
                controller: _barcodeController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Enter Price'),
              CustomTextField(
                hint: 'Price',
                controller: _priceController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Enter Price before Discount'),
              CustomTextField(
                hint: 'Price before Discount',
                controller: _priceBeforeController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              MultiBlocListener(
                listeners: [
                  BlocListener<FetchUserCategoriesCubit,
                      FetchUserCategoriesStates>(
                    listener: (context, state) {
                      if (state is FetchUserCategoriesCubitLoading) {
                        UIUtils.showLoading(context);
                      }
                      if (state is FetchUserCategoriesCubitSuccess &&
                          state.categories.isNotEmpty) {
                        setState(() {
                          selectedCategory = state.categories.first;
                        });
                        UIUtils.hideLoading(context);
                      } else if (state is FetchUserCategoriesCubitErrorr) {
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      }
                    },
                  ),
                ],
                child: BlocListener<AddProductCubit, AddProductStates>(
                  listener: (context, state) {
                    if (state is ProductAddLoading) {
                      UIUtils.showLoading(context);
                    } else if (state is ProductAddError) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.message);
                    } else if (state is ProductAddSuccess) {
                      UIUtils.hideLoading(context);
                    }
                  },
                  child: CustomElevatedButton(
                    label: 'Add',
                    onTap: () {
                      log(selectedCategory!.id);
                      log(selectedCategory!.name);
                      final barcode = int.parse(_barcodeController.text);
                      final price = double.parse(_priceController.text);
                      final priceBefore =
                          double.parse(_priceBeforeController.text);
                      if (selectedCategory == null) {
                        UIUtils.showMessage('Please select a category first');
                        return;
                      }
                      _productCubit.addProduct(
                        ProductModel(
                          name: _productName.text,
                          category: selectedCategory!,
                          barcode: barcode,
                          price: price,
                          discount: priceBefore,
                          id: '',
                        ),
                        _storeGetCubit.userStore!.id,
                        selectedCategory!.id,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
