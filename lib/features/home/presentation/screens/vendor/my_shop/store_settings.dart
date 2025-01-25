import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/image_functions.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/core/widgets/drop_button.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = serviceLocator.get<SharedPreferences>();
    setState(() {
      nameController.text = prefs.getString(SharedPrefKeys.storeName) ?? '';
      taglineController.text =
          prefs.getString(SharedPrefKeys.storeTagline) ?? '';
      addressController.text =
          prefs.getString(SharedPrefKeys.storeAddress) ?? '';
      locationController.text =
          prefs.getString(SharedPrefKeys.storeLocation) ?? '';
      minOrderController.text =
          prefs.getString(SharedPrefKeys.storeMinOrder) ?? '';
      selectedCity = prefs.getString(SharedPrefKeys.storeCity);
      selectedPaymentMethod =
          prefs.getString(SharedPrefKeys.storePaymentMethod);

      String? logoPath = prefs.getString(SharedPrefKeys.storeLogo);
      if (logoPath != null && File(logoPath).existsSync()) {
        imageFile = File(logoPath);
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = serviceLocator.get<SharedPreferences>();
    await prefs.setString(SharedPrefKeys.storeName, nameController.text);
    await prefs.setString(SharedPrefKeys.storeTagline, taglineController.text);
    await prefs.setString(SharedPrefKeys.storeAddress, addressController.text);
    await prefs.setString(
        SharedPrefKeys.storeLocation, locationController.text);
    await prefs.setString(
        SharedPrefKeys.storeMinOrder, minOrderController.text);
    await prefs.setString(SharedPrefKeys.storeCity, selectedCity ?? '');
    await prefs.setString(
        SharedPrefKeys.storePaymentMethod, selectedPaymentMethod ?? '');

    if (imageFile != null) {
      await prefs.setString(
        SharedPrefKeys.storeLogo,
        imageFile!.path,
      );
    }
  }

  File? imageFile;

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
              CustomElevatedButton(
                backgroundColor: ColorManager.starRate,
                label: 'Save',
                onTap: () {
                  _saveData();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
