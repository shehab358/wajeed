class CreateStoreStates {}

class CreateStoreStatesInitial extends CreateStoreStates {}

class StoreCreateLoading extends CreateStoreStates {}

class StoreCreateSuccess extends CreateStoreStates {}

class StoreCreateError extends CreateStoreStates {
  final String message;

  StoreCreateError(this.message);
}
