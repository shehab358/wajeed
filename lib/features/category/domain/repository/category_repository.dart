import 'package:dartz/dartz.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> fetchCategories();
  Future<Either<Failure, void>> addCategory(
    CategoryModel categoryModel,
  );
  Future<Either<Failure, void>> delete(
    String categoryId,
  );
}
