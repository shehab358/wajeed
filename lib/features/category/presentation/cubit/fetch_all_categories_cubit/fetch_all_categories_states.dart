import 'package:wajeed/features/category/domain/entities/category.dart';

class FetchAllCategoriesStates {}

class FetchAllCategoriesCubitInitial extends FetchAllCategoriesStates {}

class FetchAllCategoriesCubitSuccess extends FetchAllCategoriesStates {
  final List<Category> categories;

  FetchAllCategoriesCubitSuccess(
    this.categories,
  );
}

class FetchAllCategoriesCubitLoading extends FetchAllCategoriesStates {}

class FetchAllCategoriesCubitErrorr extends FetchAllCategoriesStates {
  final String message;

  FetchAllCategoriesCubitErrorr(this.message);
}
