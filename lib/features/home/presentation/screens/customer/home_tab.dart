import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/home/presentation/widgets/custom_slider.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/category_item.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/delivery_location_bottom_sheet.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/filter.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/profile.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/store_item.dart';
import 'package:wajeed/features/store/presentation/cubit/all_stores_get_cubit/all_stores_get_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/all_stores_get_cubit/all_stores_get_states.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  final AllStoresGetCubit storeCubit = serviceLocator.get<AllStoresGetCubit>();
  late Timer _timer;
  final List<String> _sliderImages = [
    ImageAssets.offer1,
    ImageAssets.offer2,
    ImageAssets.offer3,
  ];
  @override
  void initState() {
    super.initState();
    _startImageSwitching();
    storeCubit.getAllStores();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.s16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Delevirng to',
                              style: getRegularStyle(
                                color: ColorManager.grey,
                              ).copyWith(
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Row(
                            children: [
                              Text(
                                'KAFD Al Aqiq, Riyadh',
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                ).copyWith(
                                  fontSize: FontSize.s18,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_down_outlined),
                                color: ColorManager.black,
                                onPressed: () =>
                                    _showDeliveryLocationBottomSheet(
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        return _showProfile(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: ColorManager.primary,
                        foregroundColor: ColorManager.black,
                        child: Text(
                          'H',
                          style: getBoldStyle(
                            color: ColorManager.black,
                          ).copyWith(
                            fontSize: FontSize.s18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hint: 'Search',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    Container(
                      height: 50.h,
                      width: 50.w,
                      margin: EdgeInsets.only(left: Insets.s12),
                      decoration: BoxDecoration(
                        color: ColorManager.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                        ),
                        onPressed: () => _showFilter(context),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) => CategoryItem(
                      image: categories[index].image,
                      name: categories[index].name,
                      route: categories[index].route,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomSlider(
                  imagesPaths: _sliderImages,
                  currentIndex: _currentIndex,
                  timer: _timer,
                ),
                SizedBox(
                  height: 15.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nearby stores',
                      style: getBoldStyle(
                        color: ColorManager.black,
                      ).copyWith(
                        fontSize: FontSize.s20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.allStores);
                      },
                      child: Text(
                        'View all',
                        style: getRegularStyle(
                          color: ColorManager.starRate,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150.h,
                  child: BlocBuilder<AllStoresGetCubit, AllStoresGetStates>(
                    builder: (context, state) {
                      if (state is AllStoresGetLoading) {
                        return LoadingIndicator();
                      } else if (state is AllStoresGetError) {
                        return ErrorIndicator(state.message);
                      } else if (state is AllStoresGetSuccess) {
                        return ListView.builder(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.store,
                                arguments: state.stores[index],
                              );
                            },
                            child: StoreItem(
                              storeCubit.stores[index],
                            ),
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: storeCubit.stores.length,
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProfile(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => ProfilePage());
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(
        () => _currentIndex = (_currentIndex + 1) % _sliderImages.length,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

void _showDeliveryLocationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const DeliveryLocationBottomSheet(),
  );
}

void _showFilter(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const Filter(),
  );
}

List<CategoryItem> categories = [
  CategoryItem(
    image: ImageAssets.food,
    name: 'Food',
    route: Routes.food,
  ),
  CategoryItem(
    image: ImageAssets.grocery,
    name: 'Grocery',
    route: Routes.grocery,
  ),
  CategoryItem(
    image: ImageAssets.medicine,
    name: 'Medicine',
    route: Routes.medicine,
  ),
];
