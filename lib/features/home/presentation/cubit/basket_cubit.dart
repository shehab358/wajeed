import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/home/presentation/cubit/basket_states.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

@lazySingleton
class BasketCubit extends Cubit<BasketState> {
  List<Product> basketProducts = [];
  late String storeId;
  late String ownerId;
  late String storeName;

  BasketCubit() : super(BasketInitial());

  void addProductToBasket(
      {required Product product,
      required String storeId,
      required String ownerId,
      required String storeName}) {
    if (basketProducts.isEmpty) {
      this.storeId = storeId;
      this.ownerId = ownerId;
      this.storeName = storeName;
    } else if (this.storeId != storeId) {
      emit(BasketError("You can only add products from one store at a time."));
      return;
    }

    basketProducts.add(product);
    emit(BasketUpdated(basketProducts, this.storeId));
  }

  void clearBasket() {
    basketProducts.clear();
    emit(BasketUpdated([], storeId));
  }
}
