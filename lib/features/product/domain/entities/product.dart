import 'dart:io';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  String id;
  final File? imageFile;
  final String name;
  final String category;
  final int barcode;
  final double price;
  final double? discount;
  Product(
    this.id, {
    required this.imageFile,
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
        imageFile,
        name,
        category,
        barcode,
        price,
        discount,
      ];
}
