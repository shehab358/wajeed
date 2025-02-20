import 'package:wajeed/features/category/domain/entities/category.dart';

class FetchUserCategoriesStates {}

class FetchUserCategoriesCubitInitial extends FetchUserCategoriesStates {}

class FetchUserCategoriesCubitSuccess extends FetchUserCategoriesStates {
  final List<Category> categories;

  FetchUserCategoriesCubitSuccess(
    this.categories,
  );
}

class FetchUserCategoriesCubitLoading extends FetchUserCategoriesStates {}

class FetchUserCategoriesCubitErrorr extends FetchUserCategoriesStates {
  final String message;

  FetchUserCategoriesCubitErrorr(this.message);
}
