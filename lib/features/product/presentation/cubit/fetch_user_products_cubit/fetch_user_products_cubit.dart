import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';
import 'package:wajeed/features/product/domain/use_case/fetch_user_product.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_user_products_cubit/fetch_user_products_states.dart';

@lazySingleton
class FetchUserProductsCubit extends Cubit<FetchUserProductsStates> {
  FetchUserProductsCubit(this._fetchUserProducts)
      : super(
          FetchUserProductsCubitInitial(),
        );
  final FetchUserProducts _fetchUserProducts;
  List<Product> products = [];

  Future<void> fetchUserProducts(
    String storeId,
    String categoryId,
  ) async {
    emit(
      FetchUserProductsLoading(),
    );
    final result = await _fetchUserProducts(
      storeId,
      categoryId,
    );
    result.fold(
      (failure) => emit(
        FetchUserProductsError(
          failure.message,
        ),
      ),
      (r) {
        products = r; // تحديث القائمة بالبيانات المسترجعة
        emit(FetchUserProductsSuccess(products));
      },
    );
  }
}
