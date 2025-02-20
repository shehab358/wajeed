import 'package:wajeed/features/store/domain/entities/store.dart';

class StoreGetStates {}

class StoreGetStatesInitial extends StoreGetStates {}

class StoreGetLoading extends StoreGetStates {}

class StoreGetSuccess extends StoreGetStates {
  final Store store;

  StoreGetSuccess(this.store);
}

class StoreGetError extends StoreGetStates {
  final String message;

  StoreGetError(this.message);
}
