import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/use_case/add_product.dart';
import 'package:wajeed/features/product/presentation/cubit/add_product_cubit/add_product_states.dart';

@lazySingleton
class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit(this._addProduct) : super(AddProductStatesInitial());
  final AddProduct _addProduct;

  Future<void> addProduct(
      ProductModel product, String storeId, String categoryId) async {
    emit(ProductAddLoading());
    final result = await _addProduct(
      product,
      storeId,
      categoryId,
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
}
