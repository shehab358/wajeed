import 'package:dartz/dartz.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<Store>>> getAllStores();
  Future<Either<Failure, Store>> getStore();
  Future<Either<Failure, void>> createStore(
    StoreModel store,
    String userId,
  );
  Future<Either<Failure, void>> updateStore(
    StoreModel store,
    String userId,
  );
  Future<Either<Failure, void>> deleteStore(
    String storeName,
    String userId,
  );
}
