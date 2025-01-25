import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/presentation/cubit/category_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/category_state.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({super.key});

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  final CategoryCubit _categoryCubit = serviceLocator.get<CategoryCubit>();

  final TextEditingController _categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Insets.s16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter Category Name'),
            CustomTextField(
              hint: 'Category Name',
              controller: _categoryController,
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocListener<CategoryCubit, CategoryState>(
              listener: (context, state) async {
                if (state is CategoryAddLoading) {
                  UIUtils.showLoading(context);
                } else if (state is CategoryAddError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is CategoryAddSuccess) {
                  UIUtils.hideLoading(context);
                  await _categoryCubit.fetchCategories();
                  Navigator.pop(context);
                }
              },
              child: CustomElevatedButton(
                label: 'Add',
                onTap: () {
                  final CategoryModel category = CategoryModel(
                    FirebaseAuth.instance.currentUser!.uid,
                    name: _categoryController.text,
                  );
                  _categoryCubit.addCategory(
                    category,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
