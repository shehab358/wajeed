import 'package:dartz/dartz.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> fetchProducts();
  Future<Either<Failure, void>> addProducts(
    ProductModel productModel,
  );
  Future<Either<Failure, void>> delete(
    String productId,
  );
}