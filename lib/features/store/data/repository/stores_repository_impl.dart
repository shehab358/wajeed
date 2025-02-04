import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/store/data/data_source/store_remote_data_source.dart';
import 'package:wajeed/features/store/data/mappers/store_mappers.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';
import 'package:wajeed/features/store/domain/repository/stores_repository.dart';

@LazySingleton(as: StoreRepository)
class StoresRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource storeRemoteDataSource;

  StoresRepositoryImpl(this.storeRemoteDataSource);
  @override
  Future<Either<Failure, List<Store>>> getAllStores() async {
    try {
      final storeModels = await storeRemoteDataSource.getAllStores();
      final stores = storeModels
          .map(
            (storeModel) => storeModel.toEntity,
          )
          .toList();

      return right(
        stores,
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
  Future<Either<Failure, void>> createStore(
      StoreModel store, String userId) async {
    try {
      await storeRemoteDataSource.createStore(
        store,
      );
      return right(
        null,
      );
    } on AppException catch (e) {
      log(e.toString());

      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteStore(
      String storeName, String userId) async {
    try {
      await storeRemoteDataSource.deleteStore(
        storeName,
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
  Future<Either<Failure, void>> updateStore(
      StoreModel store, String userId) async {
    try {
      await storeRemoteDataSource.updateStore(
        store,
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
  Future<Either<Failure, Store>> getStore() async {
    try {
      final storeModel = await storeRemoteDataSource.getStore();
      final store = storeModel.toEntity;
      return right(
        store,
      );
    } on AppException catch (e) {
      log(e.message);
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
