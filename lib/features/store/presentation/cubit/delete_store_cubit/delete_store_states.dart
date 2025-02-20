class DeleteStoreStates {}

class DeleteStoreStatesInitial extends DeleteStoreStates {}

class StoreDeleteLoading extends DeleteStoreStates {}

class StoreDeleteSuccess extends DeleteStoreStates {}

class StoreDeleteError extends DeleteStoreStates {
  final String message;

  StoreDeleteError(
    this.message,
  );
}
