import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:wajeed/features/orders/domain/repository/order_repository.dart';

@lazySingleton
class UpdateOrder {
  final OrderRepository _repository;

  UpdateOrder(this._repository);

  Future<Either<Failure, void>> call({
    required ORder order,
    required String ownerId,
    required String storeId,
    required String newStatus,
    int? newDuration,
  }) async {
    return await _repository.updateOrder(
      order: order,
      ownerId: ownerId,
      storeId: storeId,
      newStatus: newStatus,
      newDuration: newDuration,
    );
  }
}
