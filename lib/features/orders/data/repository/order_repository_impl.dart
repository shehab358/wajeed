import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:wajeed/features/orders/data/mappers/order_mappers.dart';
import 'package:wajeed/features/orders/data/models/order_model.dart';
import 'package:wajeed/features/orders/domain/repository/order_repository.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRepositoryImpl(this.orderRemoteDataSource);

  @override
  Future<Either<Failure, void>> createOrder(
      OrderModel order, String storeId, String ownerId) async {
    try {
      await orderRemoteDataSource.createOrder(order, storeId, ownerId);
      return Right(null);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ORder>>> fetchUserOrders() async {
    try {
      final orderModel = await orderRemoteDataSource.fetchUserOrders();
      final orders = orderModel
          .map(
            (orderModel) => orderModel.toEntity,
          )
          .toList();
      return right(orders);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ORder>>> fetchUserStoreOrder(
      String storeId) async {
    try {
      final orderModel = await orderRemoteDataSource.fetchStoreOrders(
        storeId,
      );
      final orders = orderModel
          .map(
            (orderModel) => orderModel.toEntity,
          )
          .toList();
      return right(orders);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateOrder({
    required ORder order,
    required String ownerId,
    required String storeId,
    required String newStatus,
    int? newDuration,
  }) async {
    try {
      await orderRemoteDataSource.updateOrder(
        order: order,
        ownerId: ownerId,
        storeId: storeId,
        newStatus: newStatus,
        newDuration: newDuration,
      );
      return Right(null);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
