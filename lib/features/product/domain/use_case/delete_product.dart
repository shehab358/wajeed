import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/domain/repository/product_repository.dart';

@lazySingleton
class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Failure, void>> call(
    String productId,
  ) async {
    return await repository.delete(
      productId,
    );
  }
}
