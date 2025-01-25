import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/repository/product_repository.dart';

@lazySingleton
class FetchProducts {
  final ProductRepository repository;

  FetchProducts(this.repository);

  Future<Either<Failure, List<ProductModel>>> call() async {
    return await repository.fetchProducts();
  }
}
