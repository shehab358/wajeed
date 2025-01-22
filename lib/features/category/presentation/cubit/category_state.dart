import 'package:wajeed/features/category/data/models/category_model.dart';

abstract class CategoryState {}

class CategortyInitial extends CategoryState {}

class CategoryAddLoading extends CategoryState {}

class CategoryAddSuccess extends CategoryState {}

class CategoryAddError extends CategoryState {
  final String message;

  CategoryAddError(this.message);
}

class CategoryGetLoading extends CategoryState {}

class CategoryGetSuccess extends CategoryState {
  final List<CategoryModel> categories;

  CategoryGetSuccess(this.categories);
}

class CategoryGetError extends CategoryState {
  final String message;

  CategoryGetError(this.message);
}

class CategoryDeleteLoading extends CategoryState {}

class CategoryDeleteSuccess extends CategoryState {}

class CategoryDeleteError extends CategoryState {
  final String message;

  CategoryDeleteError(this.message);
}
