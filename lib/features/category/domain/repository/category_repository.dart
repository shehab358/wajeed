import 'package:dartz/dartz.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> fetchUserCategories(String storeId);
  Future<Either<Failure, List<Category>>> fetchAllCategories(String storeId);
  Future<Either<Failure, void>> addCategory(
      CategoryModel categoryModel, String storeId);
  Future<Either<Failure, void>> delete(String categoryName, String storeId);
}
