import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';
import 'package:wajeed/features/store/domain/repository/stores_repository.dart';

@lazySingleton
class GetAllStores {
  final StoreRepository _storeRepository;

  GetAllStores(this._storeRepository);

  Future<Either<Failure, List<Store>>> call() async =>
      await _storeRepository.getAllStores();
}
