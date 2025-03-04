import 'package:dartz/dartz.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/orders/data/models/order_model.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<ORder>>> fetchUserOrders();
  Future<Either<Failure, List<ORder>>> fetchUserStoreOrder(String storeId);
  Future<Either<Failure, void>> createOrder(
      OrderModel order, String storeId, String ownerId);
}
