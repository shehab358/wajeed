import 'package:equatable/equatable.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  String id;
  final String name;
  final Category category;
  final int barcode;
  final double price;
  final double? discount;
  Product({
    this.id = '',
    required this.name,
    required this.category,
    required this.barcode,
    required this.price,
    this.discount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        category,
        barcode,
        price,
        discount,
      ];
}
