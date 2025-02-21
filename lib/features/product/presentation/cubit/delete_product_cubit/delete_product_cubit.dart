import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/product/domain/use_case/delete_product.dart';
import 'package:wajeed/features/product/presentation/cubit/delete_product_cubit/delete_product_states.dart';

@lazySingleton
class DeleteProductCubit extends Cubit<DeleteProductStates> {
  DeleteProductCubit(
    this._deleteProduct,
  ) : super(DeleteProductInitial());
  final DeleteProduct _deleteProduct;
  Future<void> deleteProduct(
    String productId,
    String storeId,
    String categoryId,
  ) async {
    emit(ProductDeleteLoading());
    final result = await _deleteProduct(
      productId,
      storeId,
      categoryId,
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
