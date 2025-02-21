import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/data/data_source/product_remote_data_source.dart';
import 'package:wajeed/features/product/data/mappers/product_mappers.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';
import 'package:wajeed/features/product/domain/repository/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  @override
  Future<Either<Failure, void>> addProducts(
      ProductModel productModel, String storeId, String categoryId) async {
    try {
      await productRemoteDataSource.addProduct(
        productModel,
        storeId,
        categoryId,
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
  Future<Either<Failure, void>> delete(
      String productId, String storeId, String categoryId) async {
    try {
      await productRemoteDataSource.deleteProduct(
        productId,
        storeId,
        categoryId,
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

  @override
  Future<Either<Failure, List<Product>>> fetchAllProducts(
    String storeId,
    String categoryId,
  ) async {
    try {
      final productModel = await productRemoteDataSource.fetchAllProducts(
        storeId,
        categoryId,
      );
      final products = productModel
          .map(
            (productModel) => productModel.toEntity,
          )
          .toList();
      return right(
        products,
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

  @override
  Future<Either<Failure, List<Product>>> fetchUserProducts(
 String storeId, String categoryId) async {
    try {
      final productModel = await productRemoteDataSource.fetchUserProducts(
        storeId,
        categoryId,
      );
      final products = productModel
          .map(
            (productModel) => productModel.toEntity,
          )
          .toList();
      return right(
        products,
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
