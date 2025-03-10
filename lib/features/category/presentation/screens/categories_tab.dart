import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:wajeed/features/category/presentation/widgets/add_category_widget.dart';
import 'package:wajeed/features/category/presentation/widgets/category_item.dart';

class CategoriesTab extends StatefulWidget {
  final String storeId;
  const CategoriesTab({super.key, required this.storeId});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  // final FetchUserCategoriesCubit _fetchUserCategoryCubit =
  //     serviceLocator.get<FetchUserCategoriesCubit>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchUserCategoriesCubit>(context)
        .fetchUserCategories(widget.storeId);
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
                    _addCategory(context);
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
                      itemCount: categories.length,
                      itemBuilder: (context, index) => CategoryItem(
                        categories[index],
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

  void _addCategory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddCategoryWidget(),
    );
  }
}
