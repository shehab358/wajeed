class UpdateStoreStates {}

class UpdateStoreStatesInitial extends UpdateStoreStates {}

class StoreUpdateLoading extends UpdateStoreStates {}

class StoreUpdateSuccess extends UpdateStoreStates {}

class StoreUpdateError extends UpdateStoreStates {
  final String message;

  StoreUpdateError(
    this.message,
  );
}
