class CreateOrderStates {}

class CreateOrderCubitInitial extends CreateOrderStates {}

class CreateOrderCubitLoading extends CreateOrderStates {}

class CreateOrderCubitSuccess extends CreateOrderStates {}

class CreateOrderCubitError extends CreateOrderStates {
  final String message;
  CreateOrderCubitError(
    this.message,
  );
}
