import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';
import 'package:wajeed/features/product/domain/repository/product_repository.dart';

@lazySingleton
class FetchAllProducts {
  final ProductRepository repository;

  FetchAllProducts(
    this.repository,
  );

  Future<Either<Failure, List<Product>>> call(
    String storeId,
    String categoryId,
  ) async {
    return await repository.fetchAllProducts(
      storeId,
      categoryId,
    );
  }
}
