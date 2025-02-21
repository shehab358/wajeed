class AddProductStates {}

class AddProductStatesInitial extends AddProductStates {}

class ProductAddLoading extends AddProductStates {}

class ProductAddSuccess extends AddProductStates {}

class ProductAddError extends AddProductStates {
  final String message;

  ProductAddError(this.message);
}
