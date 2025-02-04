import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/auth/data/models/user_model.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';

abstract class ProductRemoteDataSource {
  CollectionReference<UserModel> getUsersCollection();
  CollectionReference<ProductModel> getProductsCollection(String userId);
  Future<List<ProductModel>> fetchProducts();
  Future<void> addProduct(ProductModel productModel);
  Future<void> delete(String productName);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductFirebaseRemoteDataSource implements ProductRemoteDataSource {
  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  CollectionReference<UserModel> getUsersCollection() {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) =>
                UserModel.fromJson(docSnapshot.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
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
  CollectionReference<ProductModel> getProductsCollection(String userId) {
    try {
      return getUsersCollection()
          .doc(userId)
          .collection('products')
          .withConverter<ProductModel>(
            fromFirestore: (docSnapshot, _) =>
                ProductModel.fromJson(docSnapshot.data()!),
            toFirestore: (productModels, _) => productModels.toJson(),
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
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<ProductModel> productCollection =
          getProductsCollection(userId);
      QuerySnapshot<ProductModel> querySnapshot = await productCollection.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
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
  Future<void> addProduct(ProductModel productModel) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<ProductModel> productCollection =
          getProductsCollection(userId);
      await productCollection.add(
        productModel,
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
  Future<void> delete(String productName) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final CollectionReference<ProductModel> productCollection =
          getProductsCollection(userId);

      QuerySnapshot<ProductModel> snapshot = await productCollection
          .where('name', isEqualTo: productName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          await doc.reference.delete(); 
          log('Deleted document with ID: ${doc.id}');
        }
      } else {
        log('No document found with productName: $productName');
      }
    } catch (e, stackTrace) {
      log('Failed to delete product: $e');
      log('Stack Trace: $stackTrace');

      String? message;
      if (e is FirebaseException) {
        message = e.message;
      }
      throw RemoteException(
        message ?? 'An error occurred while deleting the product.',
      );
    }
  }
}
