import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/domain/use_case/add_category.dart';
import 'package:wajeed/features/category/domain/use_case/delete_category.dart';
import 'package:wajeed/features/category/domain/use_case/fetch_categories.dart';
import 'package:wajeed/features/category/presentation/cubit/category_state.dart';

@lazySingleton
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(
    this._addCategory,
    this._fetchCategories,
    this._deleteCategory,
  ) : super(CategortyInitial());
  final AddCategory _addCategory;
  final FetchCategories _fetchCategories;
  final DeleteCategory _deleteCategory;

  List<CategoryModel> categories = [];

  Future<void> fetchCategories() async {
    emit(CategoryGetLoading());
    final result = await _fetchCategories();
    result.fold(
      (failure) => emit(
        CategoryGetError(
          failure.message,
        ),
      ),
      (r) => emit(
        CategoryGetSuccess(
          categories = r,
        ),
      ),
    );
  }

  Future<void> addCategory(CategoryModel category) async {
    emit(CategoryAddLoading());
    final result = await _addCategory(
      category,
    );
    result.fold(
      (failure) => emit(
        CategoryAddError(
          failure.message,
        ),
      ),
      (_) => emit(
        CategoryAddSuccess(),
      ),
    );
  }

  Future<void> deleteCategory(String categoryName) async {
    emit(CategoryDeleteLoading());
    final result = await _deleteCategory(
      categoryName,
    );
    result.fold((failure) {
      emit(
        CategoryDeleteError(
          failure.message,
        ),
      );
      log(
        "failed cubit",
      );
    }, (_) {
      emit(
        CategoryDeleteSuccess(),
      );
      log("deleted cubit");
    });
  }
}
