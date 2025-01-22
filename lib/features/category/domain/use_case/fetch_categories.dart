import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/domain/repository/category_repository.dart';

@lazySingleton
class FetchCategories {
  final CategoryRepository repository;

  FetchCategories(this.repository);

  Future<Either<Failure, List<CategoryModel>>> call(
  ) async {
    return await repository.fetchCategories();
  }
}
