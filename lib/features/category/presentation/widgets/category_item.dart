import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/presentation/cubit/category_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/category_state.dart';

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
  final CategoryCubit _categoryCubit = serviceLocator.get<CategoryCubit>();

  @override
  Widget build(BuildContext context) {
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
            BlocListener<CategoryCubit, CategoryState>(
              listener: (context, state) {
                if (state is CategoryDeleteLoading) {
                  UIUtils.showLoading(context);
                } else if (state is CategoryDeleteError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is CategoryDeleteSuccess) {
                  UIUtils.hideLoading(context);
                  _categoryCubit.fetchCategories();
                }
              },
              child: IconButton(
                onPressed: () {
                  UIUtils.showDeleteWarning(
                    context,
                    () {
                      _categoryCubit.deleteCategory(
                        widget.category.id,
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
