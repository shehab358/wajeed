import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/presentation/cubit/delete_category_c/delete_category_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/delete_category_c/delete_category_states.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart';

class CategoryItem extends StatefulWidget {
  final Category category;
  const CategoryItem(
    this.category, {
    super.key,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final DeleteCategoryCubit _categoryCubit =
      serviceLocator.get<DeleteCategoryCubit>();
  final FetchUserCategoriesCubit _fetchUserCategoryCubit =
      serviceLocator.get<FetchUserCategoriesCubit>();
  final StoreGetCubit _storeCubit = serviceLocator.get<StoreGetCubit>();

  @override
  void initState() {
    super.initState();
    _storeCubit.getStore();
  }

  @override
  Widget build(BuildContext context) {
    String storeId = _storeCubit.userStore!.id;

    return Card(
      elevation: 2,
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(
            horizontal: Insets.s16.w, vertical: Insets.s18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.r,
          ),
          color: ColorManager.white,
        ),
        child: Row(
          children: [
            Text(
              widget.category.name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            BlocListener<DeleteCategoryCubit, DeleteCategoryStates>(
              listener: (context, state) {
                if (state is DeleteCategoryCubitLoading) {
                  UIUtils.showLoading(context);
                } else if (state is DeleteCategoryCubitErrorr) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is DeleteCategoryCubitSuccess) {
                  UIUtils.hideLoading(context);
                  _fetchUserCategoryCubit.fetchUserCategories(storeId);
                }
              },
              child: IconButton(
                onPressed: () {
                  UIUtils.showDeleteWarning(
                    context,
                    () {
                      _categoryCubit.deleteCategory(
                        widget.category.name,
                        storeId,
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: ColorManager.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
