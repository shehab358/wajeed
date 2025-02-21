import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/product/data/models/product_models.dart';

abstract class ProductRemoteDataSource {
  CollectionReference<ProductModel> getAllStoresProductsCollection(
      String storeId, String categoryId);
  CollectionReference<ProductModel> getUserStoresProductsCollection(
      String storeId, String categoryId);
  Future<List<ProductModel>> fetchUserProducts(
      String storeId, String categoryId);
  Future<List<ProductModel>> fetchAllProducts(
      String storeId, String categoryId);

  Future<void> addProduct(
      ProductModel productModel, String storeId, String categoryId);
  Future<void> deleteProduct(
      String productName, String storeId, String categoryId);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductFirebaseRemoteDataSource implements ProductRemoteDataSource {
  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  CollectionReference<ProductModel> getAllStoresProductsCollection(
      String storeId, String categoryId) {
    return FirebaseFirestore.instance
        .collection('allStores')
        .doc(storeId)
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .withConverter<ProductModel>(
          fromFirestore: (docSnapshot, _) =>
              ProductModel.fromJson(docSnapshot.data()!),
          toFirestore: (productModel, _) => productModel.toJson(),
        );
  }

  @override
  CollectionReference<ProductModel> getUserStoresProductsCollection(
      String storeId, String categoryId) {
    final String? userId = getCurrentUserId();
    if (userId == null) {
      throw RemoteException('User not logged in');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('UserStores')
        .doc(storeId)
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .withConverter<ProductModel>(
          fromFirestore: (docSnapshot, _) =>
              ProductModel.fromJson(docSnapshot.data()!),
          toFirestore: (productModel, _) => productModel.toJson(),
        );
  }

  @override
  Future<void> addProduct(
      ProductModel productModel, String storeId, String categoryId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final newAllProductDoc =
          getAllStoresProductsCollection(storeId, categoryId).doc();
      final newProductId = newAllProductDoc.id;
      productModel = productModel.copyWith(id: newProductId);

      await newAllProductDoc.set(productModel);

      final newUserProductDoc =
          getUserStoresProductsCollection(storeId, categoryId)
              .doc(newProductId);
      await newUserProductDoc.set(productModel);
    } catch (e) {
      log(e.toString());
      String? message;
      if (e is FirebaseException) {
        message = e.message;
      }
      throw RemoteException(
          message ?? 'An error occurred while adding product');
    }
  }

  @override
  Future<void> deleteProduct(
      String productName, String storeId, String categoryId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final allProductsCollection =
          getAllStoresProductsCollection(storeId, categoryId);
      final userProductsCollection =
          getUserStoresProductsCollection(storeId, categoryId);

      QuerySnapshot<ProductModel> allSnapshot = await allProductsCollection
          .where('name', isEqualTo: productName)
          .get();
      QuerySnapshot<ProductModel> userSnapshot = await userProductsCollection
          .where('name', isEqualTo: productName)
          .get();

      if (allSnapshot.docs.isNotEmpty) {
        for (var doc in allSnapshot.docs) {
          await doc.reference.delete();
          log('Deleted from all stores with ID: ${doc.id}');
        }
      }

      if (userSnapshot.docs.isNotEmpty) {
        for (var doc in userSnapshot.docs) {
          await doc.reference.delete();
          log('Deleted from user stores with ID: ${doc.id}');
        }
      }

      if (allSnapshot.docs.isEmpty && userSnapshot.docs.isEmpty) {
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
          message ?? 'An error occurred while deleting the product.');
    }
  }

  @override
  Future<List<ProductModel>> fetchAllProducts(
      String storeId, String categoryId) async {
    try {
      CollectionReference<ProductModel> allProducts =
          getAllStoresProductsCollection(storeId, categoryId);
      QuerySnapshot<ProductModel> products = await allProducts.get();
      return products.docs.map((doc) => doc.data()).toList();
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
  Future<List<ProductModel>> fetchUserProducts(
      String storeId, String categoryId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<ProductModel> userProducts =
          getUserStoresProductsCollection(storeId, categoryId);
      log('Fetching products from path: ${userProducts.path}');

      QuerySnapshot<ProductModel> products = await userProducts.get();
      log('Number of products found: ${products.docs.length}');

      return products.docs.map((doc) => doc.data()).toList();
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
}
