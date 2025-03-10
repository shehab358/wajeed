import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:wajeed/features/orders/domain/use_case/update_order.dart';

part 'update_order_state.dart';

@lazySingleton
class UpdateOrderCubit extends Cubit<UpdateOrderState> {
  UpdateOrderCubit(
    this._updateOrder,
  ) : super(UpdateOrderInitial());
  final UpdateOrder _updateOrder;

  Future<void> updateStore({
    required ORder order,
    required String ownerId,
    required String storeId,
    required String newStatus,
    int? newDuration,
  }) async {
    emit(UpdateOrderLoading());
    final result = await _updateOrder(
      order: order,
      ownerId: ownerId,
      storeId: storeId,
      newStatus: newStatus,
      newDuration: newDuration,
    );
    result.fold(
      (failure) => emit(UpdateOrderError(failure.message)),
      (_) => emit(UpdateOrderSuccess()),
    );
  }
}
