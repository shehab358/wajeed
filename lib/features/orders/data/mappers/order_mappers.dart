import 'package:wajeed/features/orders/data/models/order_model.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';

extension OrderMappers on OrderModel {
  ORder get toEntity => ORder(
        storeId: storeId,
        status: status,
        products: products,
        total: total,
        createdAt: createdAt,
        customerId: customerId,
        duration: duration,
        orderId: orderId,
      );
}
