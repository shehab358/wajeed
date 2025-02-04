import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/store/domain/repository/stores_repository.dart';

@lazySingleton
class DeleteStore {
  final StoreRepository _storeRepository;

  DeleteStore(this._storeRepository);

  Future<Either<Failure, void>> call(String storeName, String userId) async {
    return await _storeRepository.deleteStore(storeName, userId);
  }
}
