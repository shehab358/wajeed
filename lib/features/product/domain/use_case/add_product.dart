import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/repository/product_repository.dart';

@lazySingleton
class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Either<Failure, void>> call(
    ProductModel product,
    String storeId,
    String categoryId,
  ) async {
    return await repository.addProducts(
      product,
      storeId,
      categoryId,
    );
  }
}
