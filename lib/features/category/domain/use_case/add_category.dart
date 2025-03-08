import 'package:injectable/injectable.dart';
import 'package:wajeed/features/category/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';

@lazySingleton
class AddCategory {
  final CategoryRepository repository;

  AddCategory(this.repository);

  Future<Either<Failure, void>> call(
      CategoryModel category, String storeId) async {
    return await repository.addCategory(category, storeId);
  }
}
