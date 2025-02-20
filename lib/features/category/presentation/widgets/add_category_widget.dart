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
import 'package:wajeed/features/category/presentation/cubit/add_category_cubit/add_category_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/add_category_cubit/add_category_states.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({super.key});

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  final AddCategoryCubit _addCategoryCubit =
      serviceLocator.get<AddCategoryCubit>();
  final FetchUserCategoriesCubit _fetchUserCategoryCubit =
      serviceLocator.get<FetchUserCategoriesCubit>();
  final StoreGetCubit _storeCubit = serviceLocator.get<StoreGetCubit>();
  @override
  void initState() {
    super.initState();
    _storeCubit.getStore();
  }

  final TextEditingController _categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String storeId = _storeCubit.userStore!.id;

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
            BlocListener<AddCategoryCubit, AddCategoryStates>(
              listener: (context, state) async {
                if (state is AddCategoryLoading) {
                  UIUtils.showLoading(context);
                } else if (state is AddCategoryError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is AddCategorySuccess) {
                  UIUtils.hideLoading(context);
                  await _fetchUserCategoryCubit.fetchUserCategories(storeId);
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
                  _addCategoryCubit.addCategory(category, storeId);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
