import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/orders/data/models/order_model.dart';
import 'package:wajeed/features/orders/domain/entities/order.dart';

abstract class OrderRemoteDataSource {
  CollectionReference<OrderModel> getUserOrderCollection(
    String userId,
  );
  CollectionReference<OrderModel> getUserStoreOrderCollection(
    String userId,
    String storeId,
  );
  Future<List<OrderModel>> fetchStoreOrders(String storeId);
  Future<List<OrderModel>> fetchUserOrders();
  Future<void> createOrder(
    OrderModel order,
    String storeId,
    String ownerId,
  );
  Future<void> updateOrder({
    required ORder order,
    required String ownerId,
    required String storeId,
    required String newStatus,
    int? newDuration,
  });
}

@LazySingleton(as: OrderRemoteDataSource)
class OrderFirebaseRemoteDataSource implements OrderRemoteDataSource {
  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  CollectionReference<OrderModel> getUserOrderCollection(
    String userId,
  ) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .withConverter<OrderModel>(
            fromFirestore: (docSnapshot, _) =>
                OrderModel.fromJson(docSnapshot.data()!),
            toFirestore: (orderModel, _) => orderModel.toJson(),
          );
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        message = e.code;
      }
      throw RemoteException(
        message ?? 'An error occurred',
      );
    }
  }

  @override
  CollectionReference<OrderModel> getUserStoreOrderCollection(
    String ownerId,
    String storeId,
  ) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(ownerId)
          .collection('UserStores')
          .doc(storeId)
          .collection('orders')
          .withConverter<OrderModel>(
            fromFirestore: (docSnapshot, _) =>
                OrderModel.fromJson(docSnapshot.data()!),
            toFirestore: (orderModel, _) => orderModel.toJson(),
          );
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        message = e.code;
      }
      throw RemoteException(
        message ?? 'An error occurred',
      );
    }
  }

  @override
  Future<void> createOrder(
      OrderModel order, String storeId, String ownerId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final String newOrderId = getUserOrderCollection(ownerId).doc().id;
      log('new order id $newOrderId');
      order = order.copyWith(orderId: newOrderId);

      await getUserOrderCollection(userId).doc(newOrderId).set(order);
      log('id after setting order ${order.orderId}');
      await getUserStoreOrderCollection(ownerId, storeId)
          .doc(newOrderId)
          .set(order);
    } catch (e) {
      log(e.toString());

      String? message;
      if (e is FirebaseException) {
        message = e.code;
      }
      throw RemoteException(message ?? 'An error occurred');
    }
  }

  @override
  Future<List<OrderModel>> fetchStoreOrders(String storeId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<OrderModel> userStoreOrders =
          getUserStoreOrderCollection(userId, storeId);
      QuerySnapshot<OrderModel> orders = await userStoreOrders.get();
      return orders.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      String? message;
      log(e.toString());
      if (e is FirebaseException) {
        message = e.code;
        log(e.code);
      }
      throw RemoteException(
        message ?? 'An error occurred',
      );
    }
  }

  @override
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<OrderModel> userStoreOrders =
          getUserOrderCollection(userId);
      QuerySnapshot<OrderModel> orders = await userStoreOrders.get();
      return orders.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      String? message;
      log(e.toString());
      if (e is FirebaseException) {
        message = e.code;
        log(e.code);
      }
      throw RemoteException(
        message ?? 'An error occurred',
      );
    }
  }

  @override
  Future<void> updateOrder({
    required ORder order,
    required String ownerId,
    required String storeId,
    required String newStatus,
    int? newDuration,
  }) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final CollectionReference<OrderModel> userOrderCollection =
          getUserOrderCollection(order.customerId);

      await userOrderCollection.doc(order.orderId).update({
        'status': newStatus,
        if (newDuration != null) 'duration': newDuration,
      });
      final CollectionReference<OrderModel> storeOrderCollection =
          getUserStoreOrderCollection(
        ownerId,
        storeId,
      );

      await storeOrderCollection.doc(order.orderId).update({
        'status': newStatus,
        if (newDuration != null) 'duration': newDuration,
      });
    } catch (e) {
      log(e.toString());
      String? message;
      if (e is FirebaseException) {
        message = e.code;
      }
      throw RemoteException(
        message ?? 'An error occurred',
      );
    }
  }
}
