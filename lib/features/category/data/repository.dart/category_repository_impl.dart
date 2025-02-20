import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/category/data/data_source/category_remote_data_soucre.dart';
import 'package:wajeed/features/category/data/mappers/category_mappers.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/domain/repository/category_repository.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl(
    this.categoryRemoteDataSource,
  );

  @override
  Future<Either<Failure, void>> addCategory(
      CategoryModel categoryModel, String storeId) async {
    try {
      await categoryRemoteDataSource.addCategory(categoryModel, storeId);
      return right(null);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> delete(
      String categoryName, String storeId) async {
    try {
      await categoryRemoteDataSource.delete(categoryName, storeId);
      return right(null);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Category>>> fetchAllCategories(
      String storeId) async {
    try {
      final categoryModels =
          await categoryRemoteDataSource.fetchAllCategories(storeId);
      final categories = categoryModels
          .map(
            (categoryModel) => categoryModel.toEntity,
          )
          .toList();
      return right(
        categories,
      );
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Category>>> fetchUserCategories(
      String storeId) async {
    try {
      final categoryModels =
          await categoryRemoteDataSource.fetchUserCategories(storeId);
      final categories = categoryModels
          .map(
            (categoryModel) => categoryModel.toEntity,
          )
          .toList();
      return right(
        categories,
      );
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
