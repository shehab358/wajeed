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
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_cubit.dart';
import 'package:wajeed/features/home/presentation/widgets/filter.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_user_products_cubit/fetch_user_products_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_user_products_cubit/fetch_user_products_states.dart';
import 'package:wajeed/features/product/presentation/widgets/add_product_widget.dart';
import 'package:wajeed/features/product/presentation/widgets/product_item.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final FetchUserProductsCubit _productCubit =
      serviceLocator.get<FetchUserProductsCubit>();
  final FetchUserCategoriesCubit _fetchUserCategoriesCubit =
      serviceLocator.get<FetchUserCategoriesCubit>();
  final StoreGetCubit _storeGetCubit = serviceLocator.get<StoreGetCubit>();

  String? selectedCategoryId; // الفئة المحددة
  List<Category> categories = []; // قائمة الفئات

  @override
  void initState() {
    super.initState();
    _storeGetCubit.getStore();
    final storeId = _storeGetCubit.userStore?.id;
    if (storeId != null) {
      _fetchUserCategoriesCubit.fetchUserCategories(storeId).then((_) {
        if (_fetchUserCategoriesCubit.categories.isNotEmpty) {
          setState(() {
            categories = _fetchUserCategoriesCubit.categories;
            selectedCategoryId =
                categories.first.id; // اختيار أول فئة افتراضيًا
          });
          _productCubit.fetchUserProducts(storeId, selectedCategoryId!);
        }
      });
    }
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
                      _productCubit.fetchUserProducts(
                          _storeGetCubit.userStore!.id, category.id);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? ColorManager.black : Colors.grey[300],
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
