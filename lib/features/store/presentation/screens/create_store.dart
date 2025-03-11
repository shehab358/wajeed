import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/image_functions.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/utils/validator.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/core/widgets/drop_button.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/presentation/cubit/create_store_cubit/create_store_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/create_store_cubit/create_store_states.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({super.key});

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController minOrderController = TextEditingController();
  final key = GlobalKey<FormState>();
  String? selectedCity;
  String? selectedPaymentMethod;
  String? selectedCategory;
  List<Category> egyptGovernorates = [
    Category(id: '1', name: 'Cairo'),
    Category(id: '2', name: 'Alexandria'),
    Category(id: '3', name: 'Giza'),
    Category(id: '4', name: 'Luxor'),
    Category(id: '5', name: 'Aswan'),
    Category(id: '6', name: 'Hurghada'),
    Category(id: '7', name: 'Sharm El-Sheikh'),
    Category(id: '8', name: 'Port Said'),
    Category(id: '9', name: 'Suez'),
    Category(id: '10', name: 'Ismailia'),
    Category(id: '11', name: 'Faiyum'),
    Category(id: '12', name: 'Minya'),
    Category(id: '13', name: 'Assiut'),
    Category(id: '14', name: 'Beni Suef'),
    Category(id: '15', name: 'Damietta'),
    Category(id: '16', name: 'Qena'),
    Category(id: '17', name: 'Sohag'),
    Category(id: '18', name: 'Beheira'),
    Category(id: '19', name: 'Sharqia'),
    Category(id: '20', name: 'Kafr El-Sheikh'),
    Category(id: '21', name: 'Daqahliya'),
    Category(id: '22', name: 'Matruh'),
    Category(id: '23', name: 'North Sinai'),
    Category(id: '24', name: 'South Sinai'),
    Category(id: '25', name: 'Red Sea'),
    Category(id: '26', name: 'New Valley'),
    Category(id: '27', name: 'Monufia'),
  ];
  List<Category> paymentMethods = [
    Category(
      id: '1',
      name: 'Cash',
    ),
    Category(
      id: '2',
      name: 'Credit Card',
    ),
    Category(
      id: '3',
      name: 'Credit Card And Cash',
    ),
  ];
  List<Category> categories = [
    Category(
      id: '1',
      name: 'Fast Food',
    ),
    Category(
      id: '2',
      name: 'Grocery',
    ),
    Category(
      id: '3',
      name: 'Medicine',
    ),
  ];

  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: key,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Insets.s16.h, horizontal: Insets.s20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
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
                          child: CircleAvatar(
                            radius: 35.r,
                            backgroundImage: imageFile == null
                                ? AssetImage(ImageAssets.user)
                                : FileImage(imageFile!),
                          ),
                        ),
                        SizedBox(height: Insets.s16.h),
                        Text(
                          'Update Store Logo',
                          style: getRegularStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'Name',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomTextField(
                    controller: nameController,
                    validation: Validator.validateUsername,
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'Tagline',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomTextField(
                    controller: taglineController,
                    validation: Validator.validateUsername,
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'City',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomDropButton(
                    hint: 'Select City',
                    selectedValue: selectedCity,
                    onCategorySelected: (selectid) {
                      setState(() {
                        selectedCity = selectid;
                      });
                    },
                    categories: egyptGovernorates,
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'Address',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomTextField(
                    controller: addressController,
                    validation: Validator.validateUsername,
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'Location',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomTextField(
                    controller: locationController,
                    validation: Validator.validateUsername,
                    prefixIcon: Icon(
                      Icons.location_pin,
                    ),
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'Minimum Order cost',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomTextField(
                    controller: minOrderController,
                    validation: Validator.validatePhoneNumber,
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'Payment Method',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomDropButton(
                    hint: 'Select Payment Method',
                    selectedValue: selectedPaymentMethod,
                    onCategorySelected: (selectedId) {
                      setState(() {
                        selectedPaymentMethod = selectedId;
                      });
                    },
                    categories: paymentMethods,
                  ),
                  SizedBox(height: Insets.s16.h),
                  Text(
                    'Category',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  CustomDropButton(
                    hint: 'Select Category',
                    selectedValue: selectedCategory,
                    onCategorySelected: (selectedId) {
                      setState(() {
                        selectedCategory = selectedId;
                      });
                    },
                    categories: categories,
                  ),
                  SizedBox(height: Insets.s16.h),
                  BlocListener<CreateStoreCubit, CreateStoreStates>(
                    listener: (context, state) {
                      if (state is StoreCreateLoading) {
                        UIUtils.showLoading(context);
                      } else if (state is StoreCreateError) {
                        log(state.message);
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      } else if (state is StoreCreateSuccess) {
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(
                          'Store Created Successfully',
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.vhome,
                        );
                      }
                    },
                    child: CustomElevatedButton(
                      backgroundColor: ColorManager.starRate,
                      label: 'Create Store',
                      onTap: () {
                        serviceLocator.get<CreateStoreCubit>().createStore(
                              StoreModel(
                                name: nameController.text,
                                isSales: 'false',
                                userId: UserId.id,
                                tagline: taglineController.text,
                                city: selectedCity!,
                                address: addressController.text,
                                minimumOrderCost: double.parse(
                                  minOrderController.text,
                                ),
                                paymentMethod: selectedPaymentMethod!,
                                category: selectedCategory!,
                              ),
                              UserId.id,
                            );
                        log('Create Store');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
