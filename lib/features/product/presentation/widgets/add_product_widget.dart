import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/image_functions.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/presentation/cubit/product_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/product_states.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({super.key});

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _priceBeforeController = TextEditingController();
  final ProductCubit _productCubit = serviceLocator.get<ProductCubit>();

  File? imageFile;

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
                child: GestureDetector(
                  onTap: () async {
                    File? temp = await ImageFunctions.galleryImage();
                    if (temp != null) {
                      setState(() {
                        imageFile = temp;
                      });
                    } else {
                      log('No image selected');
                    }
                    log(
                      'Pressed',
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: imageFile == null
                            ? AssetImage(IconsAssets.fastfood)
                            : FileImage(imageFile!),
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
              ),
              Text('Enter Product Name'),
              CustomTextField(
                hint: 'Product Name',
                controller: _productName,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Enter Category Name'),
              CustomTextField(
                hint: 'Category Name',
                controller: _categoryController,
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
              BlocListener<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductAddLoading) {
                    UIUtils.showLoading(context);
                  } else if (state is ProductAddError) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(state.message);
                  } else if (state is ProductAddSuccess) {
                    UIUtils.hideLoading(context);
                    _productCubit.fetchProducts();
                    Navigator.pop(context);
                  }
                },
                child: CustomElevatedButton(
                  label: 'Add',
                  onTap: () {
                    final barcode = int.parse(_barcodeController.text);
                    final price = double.parse(_priceController.text);
                    final priceBefore =
                        double.parse(_priceBeforeController.text);
                    _productCubit.addProduct(
                      ProductModel(
                        FirebaseAuth.instance.currentUser!.uid,
                        imageFile: imageFile,
                        name: _productName.text,
                        category: _categoryController.text,
                        barcode: barcode,
                        price: price,
                        discount: priceBefore,
                      ),
                    );
                  },
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
