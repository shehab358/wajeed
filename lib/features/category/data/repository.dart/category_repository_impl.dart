import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/category/data/data_source/category_remote_data_soucre.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/domain/repository/category_repository.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl(
    this.categoryRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      final categories = await categoryRemoteDataSource.fetchCategories();
      return Future.value(right(categories));
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addCategory(CategoryModel categoryModel) async {
    try {
      await categoryRemoteDataSource.addCategory(
        categoryModel,
      );
      return right(
        null,
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
  Future<Either<Failure, void>> delete(String categoryName) async {
    try {
      await categoryRemoteDataSource.delete(
        categoryName,
      );
      log('deleted repo');
      return right(
        null,
      );
    } on AppException catch (e) {
      log('failed repo');

      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
