import 'package:wajeed/features/orders/domain/entities/order.dart';

class FetchStoreOrderStates {}

class FetchStoreOrderCubitInitial extends FetchStoreOrderStates {}

class FetchStoreOrderCubitLoading extends FetchStoreOrderStates {}

class FetchStoreOrderCubitSuccess extends FetchStoreOrderStates {
  final List<ORder> orders;
  FetchStoreOrderCubitSuccess(
    this.orders,
  );
}

class FetchStoreOrderCubitError extends FetchStoreOrderStates {
  final String message;
  FetchStoreOrderCubitError(
    this.message,
  );
}
