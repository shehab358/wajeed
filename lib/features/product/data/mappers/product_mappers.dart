import 'package:wajeed/features/product/data/models/product_models.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

extension ProductMappers on ProductModel {
  Product get toEntity => Product(
        id: id,
        name: name,
        category: category,
        barcode: barcode,
        price: price,
        discount: discount,
      );
}
