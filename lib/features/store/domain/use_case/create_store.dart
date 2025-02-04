import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/domain/repository/stores_repository.dart';

@lazySingleton
class CreateStore {
  final StoreRepository _storeRepository;

  CreateStore(this._storeRepository);

  Future<Either<Failure, void>> call(StoreModel store, String userId) async {
    return await _storeRepository.createStore(store, userId);
  }
}
