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
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/core/widgets/drop_button.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/presentation/cubit/store_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/store_states.dart';

class StoreSettings extends StatefulWidget {
  const StoreSettings({super.key});

  @override
  State<StoreSettings> createState() => _StoreSettingsState();
}

class _StoreSettingsState extends State<StoreSettings> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController minOrderController = TextEditingController();
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
  final StoreCubit _storeCubit = serviceLocator.get<StoreCubit>();
  @override
  void initState() {
    super.initState();
    _storeCubit.getStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        centerTitle: true,
        title: Text(
          'Store Settings',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Insets.s16.h,
          horizontal: Insets.s20.w,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<StoreCubit, StoreStates>(
            builder: (context, state) {
              if (state is StoreGetLoading) {
                return LoadingIndicator();
              } else if (state is StoreGetError) {
                return ErrorIndicator(state.message);
              } else if (state is StoreGetSuccess) {
                final store = state.store;
                nameController.text = store.name;
                taglineController.text = store.tagline;
                addressController.text = store.address;
                minOrderController.text = store.minimumOrderCost.toString();
                selectedCity = store.city;
                selectedPaymentMethod = store.paymentMethod;
                selectedCategory = store.category;

                return Column(
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
                    BlocListener<StoreCubit, StoreStates>(
                      listener: (context, state) async {
                        if (state is StoreUpdateLoading) {
                        } else if (state is StoreUpdateError) {
                          UIUtils.showMessage(state.message);
                        } else if (state is StoreUpdateSuccess) {
                          UIUtils.hideLoading(context);
                          UIUtils.showMessage(
                            'Store Updated Successfully',
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: CustomElevatedButton(
                        backgroundColor: ColorManager.starRate,
                        label: 'Save',
                        onTap: () async {
                          await _storeCubit.updateStore(
                            StoreModel(
                              name: nameController.text,
                              userId: UserId.id,
                              id: store.id,
                              tagline: taglineController.text,
                              city: selectedCity!,
                              address: addressController.text,
                              minimumOrderCost:
                                  double.parse(minOrderController.text),
                              paymentMethod: selectedPaymentMethod!,
                              category: selectedCategory!,
                            ),
                            UserId.id,
                          );
                          await _storeCubit.getStore();
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
