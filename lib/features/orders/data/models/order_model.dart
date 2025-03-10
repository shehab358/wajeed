import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';

// ignore: must_be_immutable
class OrderModel extends ORder {
  OrderModel({
    super.orderId = '',
    super.status = 'waiting',
    super.duration = 20,
    required super.products,
    required super.total,
    required super.createdAt,
    required super.customerId,
    required super.storeId,
  });
  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'storeId': storeId,
        'status': status,
        'duration': duration,
        'products': {
          for (var product in products)
            product.id: {
              'name': product.name,
              'category': {
                'id': product.category.id,
                'name': product.category.name,
              },
              'barcode': product.barcode,
              'price': product.price,
              'discount': product.discount,
            }
        },
        'total': total,
        'createdAt': createdAt,
        'customerId': customerId,
      };
  OrderModel.fromJson(Map<String, dynamic> json)
      : this(
          orderId: json['orderId'],
          storeId: json['storeId'],
          status: json['status'],
          duration: json['duration'] ?? 20,
          products: [
            for (var product in json['products'].values)
              ProductModel.fromJson(product)
          ],
          total: json['total'],
          createdAt: json['createdAt'],
          customerId: json['customerId'],
        );

  OrderModel copyWith({
    String? orderId,
    String? name,
    String? storeId,
    String? status,
    List<ProductModel>? products,
    double? total,
    Timestamp? createdAt,
    String? customerId,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      storeId: storeId ?? this.storeId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      customerId: customerId ?? this.customerId,
      products: products ?? this.products,
      total: total ?? this.total,
    );
  }
}
