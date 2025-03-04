import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/orders/data/models/order_model.dart';
import 'package:wajeed/features/orders/domain/repository/order_repository.dart';

@lazySingleton
class CreateOrder {
  final OrderRepository _repository;

  CreateOrder(this._repository);

  Future<Either<Failure, void>> call(
    OrderModel order,
    String storeId,
    String ownerId,
  ) async {
    return await _repository.createOrder(order, storeId, ownerId);
  }
}
