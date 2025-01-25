import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/auth/data/models/user_model.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  CollectionReference<UserModel> getUsersCollection();
  CollectionReference<CategoryModel> getCategoriesCollection(String userId);
  Future<List<CategoryModel>> fetchCategories();
  Future<void> addCategory(CategoryModel categoryModel);
  Future<void> delete(String categoryName);
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
  CollectionReference<CategoryModel> getCategoriesCollection(String userId) {
    try {
      return getUsersCollection()
          .doc(userId)
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
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<CategoryModel> categoriesCollection =
          getCategoriesCollection(userId);
      QuerySnapshot<CategoryModel> querySnapshot =
          await categoriesCollection.get();
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
  Future<void> addCategory(CategoryModel categoryModel) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<CategoryModel> categoriesCollection =
          getCategoriesCollection(userId);
      await categoriesCollection.add(categoryModel);
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
  Future<void> delete(String categoryName) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final CollectionReference<CategoryModel> categoriesCollection =
          getCategoriesCollection(userId);

      QuerySnapshot<CategoryModel> snapshot = await categoriesCollection
          .where('name', isEqualTo: categoryName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          await doc.reference.delete(); 
          log('Deleted document with ID: ${doc.id}');
        }
      } else {
        log('No document found with categoryName: $categoryName');
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
