import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:wajeed/features/orders/domain/repository/order_repository.dart';

@lazySingleton
class FetchUserOrders {
  final OrderRepository _repository;

  FetchUserOrders(this._repository);

  Future<Either<Failure, List<ORder>>> call() async {
    return await _repository.fetchUserOrders();
  }
}
