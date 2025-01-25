import 'package:wajeed/features/product/domain/entities/product.dart';

// ignore: must_be_immutable
class ProductModel extends Product {
  ProductModel(
    super.id, {
    required super.imageFile,
    required super.name,
    required super.category,
    required super.barcode,
    required super.price,
    super.discount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'barcode': barcode,
        'price': price,
        'discount': discount,
      };
  ProductModel.fromJson(Map<String, dynamic> json)
      : this(
          imageFile: json['imageFile'],
          json['id'],
          name: json['name'],
          category: json['category'],
          barcode: json['barcode'],
          price: json['price'],
          discount: json['discount'],
        );
}
