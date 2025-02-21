import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

// ignore: must_be_immutable
class ProductModel extends Product {
  ProductModel({
    super.id = "",
    required super.name,
    required super.category,
    required super.barcode,
    required super.price,
    super.discount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': {
          'id': category.id,
          'name': category.name,
        },
        'barcode': barcode,
        'price': price,
        'discount': discount,
      };
  ProductModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          category: Category(
            json['category']['id'],
            name: json['category']['name'],
          ),
          barcode: json['barcode'],
          price: json['price'],
          discount: json['discount'],
        );
  ProductModel copyWith({
    String? id,
    String? name,
    Category? category,
    int? barcode,
    double? price,
    double? discount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      discount: discount ?? this.discount,
    );
  }
}
