import 'package:dartz/dartz.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> fetchUserProducts(
    String storeId,
    String categoryId,
  );
  Future<Either<Failure, List<Product>>> fetchAllProducts(
    String storeId,
    String categoryId,
  );
  Future<Either<Failure, void>> addProducts(
    ProductModel productModel,
    String storeId,
    String categoryId,
  );
  Future<Either<Failure, void>> delete(
    String productId,
    String storeId,
    String categoryId,
  );
}
