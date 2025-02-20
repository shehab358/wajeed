import 'package:wajeed/features/store/domain/entities/store.dart';

class AllStoresGetStates {}

class AllStoresGetStatesInitial extends AllStoresGetStates {}

class AllStoresGetLoading extends AllStoresGetStates {}

class AllStoresGetSuccess extends AllStoresGetStates {
  final List<Store> stores;

  AllStoresGetSuccess(this.stores);
}

class AllStoresGetError extends AllStoresGetStates {
  final String message;

  AllStoresGetError(this.message);
}
