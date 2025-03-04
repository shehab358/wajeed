import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/orders/domain/use_case/fetch_user_store_orders.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_states.dart';

@lazySingleton
class FetchStoreOrdersCubit extends Cubit<FetchStoreOrderStates> {
  FetchStoreOrdersCubit(this._fetchUserStoreOrders)
      : super(FetchStoreOrderCubitInitial());
  final FetchUserStoreOrders _fetchUserStoreOrders;

  Future<void> fetchStoreOrders(String storeId) async {
    emit(FetchStoreOrderCubitLoading());
    final result = await _fetchUserStoreOrders(storeId);
    result.fold(
      (failure) => emit(FetchStoreOrderCubitError(failure.message)),
      (orders) => emit(FetchStoreOrderCubitSuccess(orders)),
    );
  }
}
