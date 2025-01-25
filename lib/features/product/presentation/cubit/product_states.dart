import 'package:wajeed/features/product/data/models/product_models.dart';

abstract class ProductState {}

class CategortyInitial extends ProductState {}

class ProductAddLoading extends ProductState {}

class ProductAddSuccess extends ProductState {}

class ProductAddError extends ProductState {
  final String message;

  ProductAddError(this.message);
}

class ProductGetLoading extends ProductState {}

class ProductGetSuccess extends ProductState {
  final List<ProductModel> products;

  ProductGetSuccess(this.products);
}

class ProductGetError extends ProductState {
  final String message;

  ProductGetError(this.message);
}

class ProductDeleteLoading extends ProductState {}

class ProductDeleteSuccess extends ProductState {}

class ProductDeleteError extends ProductState {
  final String message;

  ProductDeleteError(
    this.message,
  );
}
