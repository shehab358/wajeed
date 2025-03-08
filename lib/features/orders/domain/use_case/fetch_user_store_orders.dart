import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:wajeed/features/orders/domain/repository/order_repository.dart';

@lazySingleton
class FetchUserStoreOrders {
  final OrderRepository _orderRepository;

  FetchUserStoreOrders(this._orderRepository);

  Future<Either<Failure, List<ORder>>> call(String storeId) async {
    return await _orderRepository.fetchUserStoreOrder(storeId);
  }
}
