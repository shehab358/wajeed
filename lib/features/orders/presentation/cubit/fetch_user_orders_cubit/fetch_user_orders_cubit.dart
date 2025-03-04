import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/orders/domain/use_case/fetch_user_orders.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_user_orders_cubit/fetch_user_orders_states.dart';

@lazySingleton
class FetchUserOrdersCubit extends Cubit<FetchUserOrderStates> {
  FetchUserOrdersCubit(
    this._fetchUserOrders,
  ) : super(
          FetchUserOrderCubitInitial(),
        );
  final FetchUserOrders _fetchUserOrders;

  Future<void> fetchUserOrders() async {
    emit(FetchUserOrderCubitLoading());
    final result = await _fetchUserOrders();
    result.fold(
      (failure) => emit(
        FetchUserOrderCubitError(
          failure.message,
        ),
      ),
      (orders) => emit(
        FetchUserOrderCubitSuccess(
          orders,
        ),
      ),
    );
  }
}
