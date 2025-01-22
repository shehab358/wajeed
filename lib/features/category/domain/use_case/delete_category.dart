import 'package:wajeed/features/category/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';

@lazySingleton
class DeleteCategory {
  final CategoryRepository repository;

  DeleteCategory(this.repository);

  Future<Either<Failure, void>> call(
    String categoryId,
  ) async {
    return await repository.delete(categoryId);
  }
}
