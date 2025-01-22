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
import 'package:wajeed/features/category/presentation/cubit/category_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/category_state.dart';
import 'package:wajeed/features/category/presentation/widgets/add_category_widget.dart';
import 'package:wajeed/features/category/presentation/widgets/category_item.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  final CategoryCubit _categoryCubit = serviceLocator.get<CategoryCubit>();

  @override
  void initState() {
    super.initState();
    _categoryCubit.fetchCategories();
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
              'Categories ',
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
                SizedBox(
                  width: 15.w,
                ),
                GestureDetector(
                  onTap: () {
                    _showFilter(context);
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
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryGetLoading) {
                    return LoadingIndicator();
                  } else if (state is CategoryGetError) {
                    return ErrorIndicator(state.message);
                  } else if (state is CategoryGetSuccess) {
                    return ListView.builder(
                      itemCount: _categoryCubit.categories.length,
                      itemBuilder: (context, index) => CategoryItem(
                        _categoryCubit.categories[index],
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
      builder: (context) => const AddCategoryWidget(),
    );
  }
}
