import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/auth/data/models/user_model.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';

abstract class StoreRemoteDataSource {
  CollectionReference<UserModel> getUsersCollection();
  CollectionReference<StoreModel> getUserStoresCollection(String userId);

  CollectionReference<StoreModel> getStoresCollection();
  Future<void> createStore(
    StoreModel store,
  );
  Future<List<StoreModel>> getAllStores();
  Future<StoreModel> getStore();

  Future<void> updateStore(
    StoreModel store,
  );
  Future<void> deleteStore(
    String storeName,
  );
}

@LazySingleton(as: StoreRemoteDataSource)
class StoreFirebaseRemoteDataSource extends StoreRemoteDataSource {
  String? getCurrentUserId() {
    final String userId = UserId.id;
    return userId;
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
  Future<List<StoreModel>> getAllStores() async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<StoreModel> storesCollection = getStoresCollection();
      QuerySnapshot<StoreModel> querySnapshot = await storesCollection.get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
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
  Future<StoreModel> getStore() async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }
      CollectionReference<StoreModel> storesCollection =
          getUserStoresCollection(userId);
      QuerySnapshot<StoreModel> store = await storesCollection.get();
      return store.docs.first.data();
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

  @override
  Future<void> createStore(StoreModel store) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final userStoresCollection = getUserStoresCollection(userId);
      final allStoresCollection = getStoresCollection();

      final newStoreDoc = userStoresCollection.doc();
      final newStoreId = newStoreDoc.id;

      store = store.copyWith(id: newStoreId);

      await newStoreDoc.set(store);

      await allStoresCollection.doc(newStoreId).set(store);

      log('Store created with ID: $newStoreId');
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
  Future<void> updateStore(StoreModel store) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final CollectionReference<StoreModel> userStoreCollection =
          getUserStoresCollection(userId);

      await userStoreCollection.doc(store.id).update(store.toJson());
      final CollectionReference<StoreModel> storesCollection =
          getStoresCollection();

      await storesCollection.doc(store.id).update(store.toJson());
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

  @override
  Future<void> deleteStore(String storeName) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw RemoteException('User not logged in');
      }

      final CollectionReference<StoreModel> userStoreCollection =
          getUserStoresCollection(userId);

      QuerySnapshot<StoreModel> snapshotI =
          await userStoreCollection.where('name', isEqualTo: storeName).get();

      if (snapshotI.docs.isNotEmpty) {
        for (var doc in snapshotI.docs) {
          await doc.reference.delete();
          log('Deleted document with ID: ${doc.id}');
        }
      } else {
        log('No document found with productName: $storeName');
      }
      final CollectionReference<StoreModel> storesCollection =
          getStoresCollection();

      QuerySnapshot<StoreModel> snapshotII =
          await storesCollection.where('name', isEqualTo: storeName).get();

      if (snapshotII.docs.isNotEmpty) {
        for (var doc in snapshotII.docs) {
          await doc.reference.delete();
          log('Deleted document with ID: ${doc.id}');
        }
      } else {
        log('No document found with productName: $storeName');
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
