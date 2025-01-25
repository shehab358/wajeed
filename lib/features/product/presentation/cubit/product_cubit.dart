import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/use_case/add_product.dart';
import 'package:wajeed/features/product/domain/use_case/delete_product.dart';
import 'package:wajeed/features/product/domain/use_case/fetch_products.dart';
import 'package:wajeed/features/product/presentation/cubit/product_states.dart';

@lazySingleton
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(
    this._addProduct,
    this._fetchProducts,
    this._deleteProduct,
  ) : super(CategortyInitial());
  final AddProduct _addProduct;
  final FetchProducts _fetchProducts;
  final DeleteProduct _deleteProduct;

  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    emit(ProductGetLoading());
    final result = await _fetchProducts();
    result.fold(
      (failure) => emit(
        ProductGetError(
          failure.message,
        ),
      ),
      (r) => emit(
        ProductGetSuccess(
          products = r,
        ),
      ),
    );
  }

  Future<void> addProduct(ProductModel product) async {
    emit(ProductAddLoading());
    final result = await _addProduct(
      product,
    );
    result.fold(
      (failure) => emit(
        ProductAddError(
          failure.message,
        ),
      ),
      (_) => emit(
        ProductAddSuccess(),
      ),
    );
  }

  Future<void> deleteProduct(String productId) async {
    emit(ProductDeleteLoading());
    final result = await _deleteProduct(
      productId,
    );
    result.fold((failure) {
      emit(
        ProductDeleteError(
          failure.message,
        ),
      );
      log(
        "failed cubit",
      );
    }, (_) {
      emit(
        ProductDeleteSuccess(),
      );
      log("deleted cubit");
    });
  }
}
