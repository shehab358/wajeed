import 'package:wajeed/features/store/domain/entities/store.dart';

abstract class StoreStates {}

class StoreInitial extends StoreStates {}

class StoreCreateLoading extends StoreStates {}

class StoreCreateSuccess extends StoreStates {}

class StoreCreateError extends StoreStates {
  final String message;

  StoreCreateError(this.message);
}

class AllStoresGetLoading extends StoreStates {}

class AllStoresGetSuccess extends StoreStates {
  final List<Store> stores;

  AllStoresGetSuccess(this.stores);
}

class AllStoresGetError extends StoreStates {
  final String message;

  AllStoresGetError(this.message);
}

class StoreGetLoading extends StoreStates {}

class StoreGetSuccess extends StoreStates {
  final Store store;

  StoreGetSuccess(this.store);
}

class StoreGetError extends StoreStates {
  final String message;

  StoreGetError(this.message);
}

class StoreDeleteLoading extends StoreStates {}

class StoreDeleteSuccess extends StoreStates {}

class StoreDeleteError extends StoreStates {
  final String message;

  StoreDeleteError(
    this.message,
  );
}

class StoreUpdateLoading extends StoreStates {}

class StoreUpdateSuccess extends StoreStates {}

class StoreUpdateError extends StoreStates {
  final String message;

  StoreUpdateError(
    this.message,
  );
}

class StoreCheckSuccess extends StoreStates {
  final bool hasStore;

  StoreCheckSuccess(
    this.hasStore,
  );
}

class StoreCheckError extends StoreStates {
  final String message;

  StoreCheckError(
    this.message,
  );
}

class StoreCheckLoading extends StoreStates {}
