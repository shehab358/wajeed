import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/auth/data/models/user_model.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';

abstract class CategoryRemoteDataSource {
  CollectionReference<UserModel> getUsersCollection();
  CollectionReference<StoreModel> getUserStoresCollection(String userId);
  CollectionReference<StoreModel> getStoresCollection();
  CollectionReference<CategoryModel> getAllStoresCategoriesCollection(
      String storeId);
  CollectionReference<CategoryModel> getUserStoresCategoriesCollection(
      String userId, String storeId);
  Future<List<CategoryModel>> fetchUserCategories(String storeId);
  Future<List<CategoryModel>> fetchAllCategories(String storeId);
  Future<void> addCategory(CategoryModel categoryModel, String storeId);
  Future<void> delete(String categoryName, String storeId);
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryFirebaseRemoteDataSource implements CategoryRemoteDataSource {
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
  CollectionReference<StoreModel> getUserStoresCollection(String userId) {
    try {
      return getUsersCollection()
          .doc(userId)
          .collection('UserStores')
          .withConverter<StoreModel>(
            fromFirestore: (docSnapshot, _) =>
                StoreModel.fromJson(docSnapshot.data()!),
            toFirestore: (storeModel, _) => storeModel.toJson(),
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
  CollectionReference<StoreModel> getStoresCollection() {
    try {
      return FirebaseFirestore.instance
          .collection('allStores')
          .withConverter<StoreModel>(
            fromFirestore: (docSnapshot, _) =>
                StoreModel.fromJson(docSnapshot.data()!),
            toFirestore: (storeModel, _) => storeModel.toJson(),
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
  CollectionReference<CategoryModel> getAllStoresCategoriesCollection(
    String storeId,
  ) {
    try {
      return getStoresCollection()
          .doc(storeId)
          .collection('categories')
          .withConverter<CategoryModel>(
            fromFirestore: (docSnapshot, _) =>
                CategoryModel.fromJson(docSnapshot.data()!),
            toFirestore: (categoryModel, _) => categoryModel.toJson(),
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
  CollectionReference<CategoryModel> getUserStoresCategoriesCollection(
      String userId, String storeId) {
    try {
      return getUserStoresCollection(userId)
          .doc(storeId)
          .collection('categories')
          .withConverter<CategoryModel>(
            fromFirestore: (docSnapshot, _) =>
                CategoryModel.fromJson(docSnapshot.data()!),
            toFirestore: (categoryModel, _) => categoryModel.toJson(),
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
  Future<void> addCategory(CategoryModel categoryModel, String storeId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final String newCategoryId =
          getAllStoresCategoriesCollection(storeId).doc().id;

      categoryModel = categoryModel.copyWith(id: newCategoryId);

      await getAllStoresCategoriesCollection(storeId)
          .doc(newCategoryId)
          .set(categoryModel);

      await getUserStoresCategoriesCollection(userId, storeId)
          .doc(newCategoryId)
          .set(categoryModel);
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
  Future<List<CategoryModel>> fetchUserCategories(String storeId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<CategoryModel> userCats =
          getUserStoresCategoriesCollection(userId, storeId);
      QuerySnapshot<CategoryModel> cats = await userCats.get();
      return cats.docs.map((doc) => doc.data()).toList();
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
  Future<List<CategoryModel>> fetchAllCategories(String storeId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<CategoryModel> userCats =
          getAllStoresCategoriesCollection(storeId);
      QuerySnapshot<CategoryModel> cats = await userCats.get();
      return cats.docs.map((doc) => doc.data()).toList();
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
  Future<void> delete(String categoryName, String storeId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final CollectionReference<CategoryModel> userCategoriesCollection =
          getUserStoresCategoriesCollection(userId, storeId);

      QuerySnapshot<CategoryModel> userSnapshot = await userCategoriesCollection
          .where('name', isEqualTo: categoryName)
          .get();

      for (var doc in userSnapshot.docs) {
        await doc.reference.delete();
        log('Deleted from user categories: ${doc.id}');
      }

      final CollectionReference<CategoryModel> allStoresCategoriesCollection =
          getAllStoresCategoriesCollection(storeId);

      QuerySnapshot<CategoryModel> allStoresSnapshot =
          await allStoresCategoriesCollection
              .where('name', isEqualTo: categoryName)
              .get();

      for (var doc in allStoresSnapshot.docs) {
        await doc.reference.delete();
        log('Deleted from all stores categories: ${doc.id}');
      }
    } catch (e, stackTrace) {
      log('Failed to delete category: $e');
      log('Stack Trace: $stackTrace');

      String? message;
      if (e is FirebaseException) {
        message = e.message;
      }
      throw RemoteException(
        message ?? 'An error occurred while deleting the category.',
      );
    }
  }
}
