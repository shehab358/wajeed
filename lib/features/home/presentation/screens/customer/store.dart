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
import 'package:wajeed/features/category/presentation/cubit/fetch_all_categories_cubit/fetch_all_categories_cubit.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/store_product_item.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/view_basket_widget.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_all_products_cubit/fetch_all_products_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_all_products_cubit/fetch_all_products_states.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';

import '../../../../category/domain/entities/category.dart';

class CustomerStore extends StatefulWidget {
  const CustomerStore({super.key});

  @override
  State<CustomerStore> createState() => _CustomerStoreState();
}

class _CustomerStoreState extends State<CustomerStore> {
  final FetchAllProductsCubit _productCubit =
      serviceLocator.get<FetchAllProductsCubit>();
  final FetchAllCategoriesCubit _fetchUserCategoriesCubit =
      serviceLocator.get<FetchAllCategoriesCubit>();

  String? selectedCategoryId;
  List<Category> categories = [];
  late Store store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = ModalRoute.of(context)!.settings.arguments as Store;
      _fetchCategoriesAndProducts();
    });
  }

  void _fetchCategoriesAndProducts() {
    final storeId = store.id;
    _fetchUserCategoriesCubit.fetchAllCategories(storeId).then((_) {
      if (_fetchUserCategoriesCubit.categories.isNotEmpty) {
        setState(() {
          categories = _fetchUserCategoriesCubit.categories;
          selectedCategoryId = categories.first.id;
        });
        _productCubit.fetchAllProducts(storeId, selectedCategoryId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = ModalRoute.of(context)!.settings.arguments as Store;

    return Scaffold(
      bottomNavigationBar: ViewBasketWidget(),
      appBar: AppBar(
        title: Text(store.name),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Insets.s16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.s8),
                child: Row(
                  children: [
                    Card(
                      elevation: 5,
                      child: Image.asset(
                        ImageAssets.mcdonalds,
                        width: 75,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: Insets.s8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.name,
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s20,
                          ),
                        ),
                        Text(
                          store.tagline,
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: ColorManager.yellow,
                            ),
                            Text(
                              'Rating: ${store.rating}',
                              style: getRegularStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Text(
                              '(${store.numberOfRatings} ratings)',
                              style: getRegularStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'SAR ${store.minimumOrderCost} min',
                          style: getRegularStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Insets.s16),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category.id == selectedCategoryId;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryId = category.id;
                        });
                        _productCubit.fetchAllProducts(
                          store.id,
                          category.id,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorManager.black
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          category.name,
                          style: getBoldStyle(
                            color: isSelected
                                ? ColorManager.white
                                : ColorManager.black,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child:
                    BlocBuilder<FetchAllProductsCubit, FetchAllProductsStates>(
                  builder: (context, state) {
                    if (state is FetchAllProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchAllProductsError) {
                      return Center(child: Text(state.message));
                    } else if (state is FetchAllProductsSuccess) {
                      log('Products in UI: ${_productCubit.products}');

                      return ListView.builder(
                        itemCount: _productCubit.products.length,
                        itemBuilder: (context, index) => StoreProductItem(
                          _productCubit.products[index],
                          storeId: store.id,
                          ownerId: store.userId,
                          storeName: store.name,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
