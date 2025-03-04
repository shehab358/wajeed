import 'package:equatable/equatable.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

abstract class BasketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BasketInitial extends BasketState {}

class BasketUpdated extends BasketState {
  final List<Product> basketItems;
  final String storeId; // ✅ إضافة storeId

  BasketUpdated(this.basketItems, this.storeId);

  @override
  List<Object> get props =>
      [basketItems, storeId]; // ✅ تضمين storeId في المقارنة
}

class BasketError extends BasketState {
  final String message; // ✅ إضافة حالة الخطأ

  BasketError(this.message);

  @override
  List<Object> get props => [message];
}
