import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/data/data_source/product_remote_data_source.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/repository/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    try {
      final products = await productRemoteDataSource.fetchProducts();
      return Future.value(
        right(
          products,
        ),
      );
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addProducts(ProductModel productModel) async {
    try {
      await productRemoteDataSource.addProduct(
        productModel,
      );
      return right(
        null,
      );
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> delete(String productId) async {
    try {
      await productRemoteDataSource.delete(
        productId,
      );
      log('deleted repo');
      return right(
        null,
      );
    } on AppException catch (e) {
      log('failed repo');

      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
