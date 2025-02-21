import 'package:wajeed/features/product/domain/entities/product.dart';

class FetchAllProductsStates {}

class FetchAllProductsCubitInitial extends FetchAllProductsStates {}

class FetchAllProductsLoading extends FetchAllProductsStates {}

class FetchAllProductsError extends FetchAllProductsStates {
  final String message;

  FetchAllProductsError(this.message);
}

class FetchAllProductsSuccess extends FetchAllProductsStates {
  final List<Product> products;

  FetchAllProductsSuccess(this.products);
}
