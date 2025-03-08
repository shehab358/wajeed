import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:wajeed/features/product/domain/entities/product.dart';

// ignore: must_be_immutable
class ORder extends Equatable {
  String orderId;
  final String storeId;
  String status;
  final List<Product> products;
  final double total;
  final Timestamp createdAt;
  final String customerId;

  ORder({
    this.orderId = '',
    required this.storeId,
    this.status = 'waiting',
    required this.products,
    required this.total,
    required this.createdAt,
    required this.customerId,
  });

  @override
  List<Object?> get props =>
      [orderId, storeId, status, products, total, createdAt, customerId];
}
