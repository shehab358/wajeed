import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/features/home/presentation/widgets/filter.dart';
import 'package:wajeed/features/product/presentation/cubit/product_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/product_states.dart';
import 'package:wajeed/features/product/presentation/widgets/add_product_widget.dart';
import 'package:wajeed/features/product/presentation/widgets/product_item.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final ProductCubit _productCubit = serviceLocator.get<ProductCubit>();

  @override
  void initState() {
    super.initState();
    _productCubit.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Insets.s18.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s24,
              ),
            ),
            SizedBox(
              height: 10.h,
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
                ),
                SizedBox(
                  width: 15.w,
                ),
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
                      child: Icon(
                        Icons.add,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductGetLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductGetError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is ProductGetSuccess) {
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
