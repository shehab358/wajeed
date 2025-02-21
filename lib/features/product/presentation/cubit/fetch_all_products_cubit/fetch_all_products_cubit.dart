import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';
import 'package:wajeed/features/product/domain/use_case/fetch_all_products.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_all_products_cubit/fetch_all_products_states.dart';

@lazySingleton
class FetchAllProductsCubit extends Cubit<FetchAllProductsStates> {
  FetchAllProductsCubit(this._fetchAllProducts)
      : super(
          FetchAllProductsCubitInitial(),
        );
  final FetchAllProducts _fetchAllProducts;
  List<Product> products = [];

  Future<void> fetchAllProducts(
    String storeId,
    String categoryId,
  ) async {
    emit(
      FetchAllProductsLoading(),
    );
    final result = await _fetchAllProducts(
      storeId,
      categoryId,
    );
    result.fold(
      (failure) => emit(
        FetchAllProductsError(
          failure.message,
        ),
      ),
      (r) => emit(
        FetchAllProductsSuccess(
          r = products,
        ),
      ),
    );
  }
}
