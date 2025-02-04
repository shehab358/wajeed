import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';
import 'package:wajeed/features/store/domain/use_case/create_store.dart';
import 'package:wajeed/features/store/domain/use_case/delete_store.dart';
import 'package:wajeed/features/store/domain/use_case/get_all_stores.dart';
import 'package:wajeed/features/store/domain/use_case/get_store.dart';
import 'package:wajeed/features/store/domain/use_case/update_store.dart';
import 'package:wajeed/features/store/presentation/cubit/store_states.dart';

@lazySingleton
class StoreCubit extends Cubit<StoreStates> {
  StoreCubit(
    this._getAllStores,
    this._createStore,
    this._updateStore,
    this._deleteStore,
    this._getStore,
  ) : super(StoreInitial());
  final GetAllStores _getAllStores;
  final CreateStore _createStore;
  final UpdateStore _updateStore;
  final DeleteStore _deleteStore;
  final GetStore _getStore;

  List<Store> stores = [];
  late Store userStore;
  Future<void> getAllStores() async {
    emit(AllStoresGetLoading());
    final result = await _getAllStores();
    result.fold(
      (failure) => emit(
        AllStoresGetError(
          failure.message,
        ),
      ),
      (r) => emit(
        AllStoresGetSuccess(
          stores = r,
        ),
      ),
    );
  }

  Future<void> createStore(StoreModel store, String userId) async {
    emit(StoreCreateLoading());
    final result = await _createStore(store, userId);
    result.fold(
      (failure) {
        log(failure.message);
        emit(
          StoreCreateError(
            failure.message,
          ),
        );
      },
      (r) => emit(
        StoreCreateSuccess(),
      ),
    );
  }

  Future<void> updateStore(StoreModel store, String userId) async {
    emit(StoreUpdateLoading());
    final result = await _updateStore(store, userId);
    result.fold(
      (failure) => emit(
        StoreUpdateError(
          failure.message,
        ),
      ),
      (r) => emit(
        StoreUpdateSuccess(),
      ),
    );
  }

  Future<void> deleteStore(
    String storeName,
    String userId,
  ) async {
    emit(StoreDeleteLoading());
    final result = await _deleteStore(
      storeName,
      userId,
    );
    result.fold(
      (failure) => emit(
        StoreDeleteError(
          failure.message,
        ),
      ),
      (r) => emit(
        StoreDeleteSuccess(),
      ),
    );
  }

  Future<void> getStore() async {
    emit(StoreGetLoading());
    final result = await _getStore();
    result.fold(
      (failure) => emit(
        StoreGetError(
          failure.message,
        ),
      ),
      (r) => emit(
        StoreGetSuccess(
          userStore = r,
        ),
      ),
    );
  }

  Future<bool> checkIfUserHasStore(String userId) async {
    try {
      if (userId.isEmpty) {
        log("User ID is empty.");
        return false;
      }

      log("Checking store for userId: $userId");

      final querySnapshot = await FirebaseFirestore.instance
          .collection('stores')
          .where('userId', isEqualTo: userId)
          .get();

      log("Number of stores found: ${querySnapshot.docs.length}");

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      log("Error checking store for userId $userId: $e");
      return false;
    }
  }
}
