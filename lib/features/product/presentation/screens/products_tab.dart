import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_states.dart';
import 'package:wajeed/features/home/presentation/widgets/filter.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_user_products_cubit/fetch_user_products_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_user_products_cubit/fetch_user_products_states.dart';
import 'package:wajeed/features/product/presentation/widgets/add_product_widget.dart';
import 'package:wajeed/features/product/presentation/widgets/product_item.dart';

class ProductsTab extends StatefulWidget {
  final String storeId;
  const ProductsTab({super.key, required this.storeId});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final FetchUserProductsCubit _productCubit =
      serviceLocator.get<FetchUserProductsCubit>();
  final FetchUserCategoriesCubit _fetchUserCategoriesCubit =
      serviceLocator.get<FetchUserCategoriesCubit>();

  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.s18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: getBoldStyle(
                  color: ColorManager.black, fontSize: FontSize.s24),
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 10.h),
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
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      _showFilter(context);
                    },
                  ),
                ),
                SizedBox(width: 15.w),
                GestureDetector(
                  onTap: () {
                    _addProduct(context);
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: ColorManager.black,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Icon(Icons.add, color: ColorManager.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 50.h,
              child: BlocProvider<FetchUserCategoriesCubit>(
                create: (context) => _fetchUserCategoriesCubit
                  ..fetchUserCategories(
                    widget.storeId,
                  ),
                child: BlocBuilder<FetchUserCategoriesCubit,
                    FetchUserCategoriesStates>(
                  builder: (context, state) {
                    if (state is FetchUserCategoriesCubitLoading) {
                      return LoadingIndicator();
                    } else if (state is FetchUserCategoriesCubitErrorr) {
                      return ErrorIndicator(state.message);
                    } else if (state is FetchUserCategoriesCubitSuccess) {
                      final List<Category> categories = state.categories;
                      if (categories.isEmpty) {
                        return const Center(
                          child: Text('No categories found'),
                        );
                      }
                      return ListView.builder(
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
                              _productCubit.fetchUserProducts(
                                widget.storeId,
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
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            // SizedBox(
            //   height: 50.h,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: categories.length,
            //     itemBuilder: (context, index) {
            //       final category = categories[index];
            //       final isSelected = category.id == selectedCategoryId;

            //       return GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selectedCategoryId = category.id;
            //           });
            //           _productCubit.fetchUserProducts(
            //               widget.storeId, category.id);
            //         },
            //         child: Container(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 16.w, vertical: 10.h),
            //           margin: EdgeInsets.symmetric(horizontal: 5.w),
            //           decoration: BoxDecoration(
            //             color:
            //                 isSelected ? ColorManager.black : Colors.grey[300],
            //             borderRadius: BorderRadius.circular(10.r),
            //           ),
            //           child: Text(
            //             category.name,
            //             style: getBoldStyle(
            //               color: isSelected
            //                   ? ColorManager.white
            //                   : ColorManager.black,
            //               fontSize: FontSize.s16,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child:
                  BlocBuilder<FetchUserProductsCubit, FetchUserProductsStates>(
                builder: (context, state) {
                  if (state is FetchUserProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FetchUserProductsError) {
                    return Center(child: Text(state.message));
                  } else if (state is FetchUserProductsSuccess) {
                    log('Products in UI: ${_productCubit.products}');

                    return ListView.builder(
                      itemCount: _productCubit.products.length,
                      itemBuilder: (context, index) => ProductItem(
                        _productCubit.products[index],
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
    );
  }

  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const Filter(),
    );
  }

  void _addProduct(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddProductWidget(),
    );
  }
}
