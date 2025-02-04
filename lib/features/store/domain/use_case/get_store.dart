import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';
import 'package:wajeed/features/store/domain/repository/stores_repository.dart';

@lazySingleton
class GetStore {
  final StoreRepository _storeRepository;

  GetStore(this._storeRepository);

  Future<Either<Failure, Store>> call() {
    return _storeRepository.getStore();
  }
}
