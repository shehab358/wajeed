class DeleteProductStates {}

class DeleteProductInitial extends DeleteProductStates {}

class ProductDeleteLoading extends DeleteProductStates {}

class ProductDeleteSuccess extends DeleteProductStates {}

class ProductDeleteError extends DeleteProductStates {
  final String message;

  ProductDeleteError(
    this.message,
  );
}
