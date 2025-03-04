import 'package:wajeed/features/orders/domain/entities/order.dart';

class FetchUserOrderStates {}

class FetchUserOrderCubitInitial extends FetchUserOrderStates {}

class FetchUserOrderCubitLoading extends FetchUserOrderStates {}

class FetchUserOrderCubitSuccess extends FetchUserOrderStates {
  final List<ORder> orders;
  FetchUserOrderCubitSuccess(
    this.orders,
  );
}

class FetchUserOrderCubitError extends FetchUserOrderStates {
  final String message;
  FetchUserOrderCubitError(
    this.message,
  );
}
