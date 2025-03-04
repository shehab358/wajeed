import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/orders/data/models/order_model.dart';
import 'package:wajeed/features/orders/domain/use_case/create_order.dart';
import 'package:wajeed/features/orders/presentation/cubit/create_oredr_cubit/create_order_states.dart';

@lazySingleton
class CreateOrderCubit extends Cubit<CreateOrderStates> {
  CreateOrderCubit(this._createOrder) : super(CreateOrderCubitInitial());
  final CreateOrder _createOrder;

  Future<void> createOrder(
    OrderModel order,
    String storeId,
    String ownerId,
  ) async {
    emit(CreateOrderCubitLoading());
    final result = await _createOrder(order, storeId, ownerId);
    result.fold(
      (failure) => emit(CreateOrderCubitError(failure.message)),
      (_) => emit(CreateOrderCubitSuccess()),
    );
  }
}
