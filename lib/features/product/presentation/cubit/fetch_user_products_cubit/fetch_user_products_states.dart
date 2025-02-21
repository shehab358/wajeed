import 'package:wajeed/features/product/domain/entities/product.dart';

class FetchUserProductsStates {}

class FetchUserProductsCubitInitial extends FetchUserProductsStates {}

class FetchUserProductsLoading extends FetchUserProductsStates {}

class FetchUserProductsError extends FetchUserProductsStates {
  final String message;

  FetchUserProductsError(this.message);
}

class FetchUserProductsSuccess extends FetchUserProductsStates {
  final List<Product> products;

  FetchUserProductsSuccess(this.products);
}
