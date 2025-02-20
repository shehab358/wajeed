import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/domain/repository/category_repository.dart';

@lazySingleton
class FetchAllCategories {
  final CategoryRepository repository;

  FetchAllCategories(this.repository);

  Future<Either<Failure, List<Category>>> call(String storeId) async {
    return await repository.fetchAllCategories(storeId);
  }
}
