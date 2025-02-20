import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/domain/use_case/create_store.dart';
import 'package:wajeed/features/store/presentation/cubit/create_store_cubit/create_store_states.dart';

@lazySingleton
class CreateStoreCubit extends Cubit<CreateStoreStates> {
  CreateStoreCubit(this._createStore) : super(CreateStoreStatesInitial());
  final CreateStore _createStore;

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
}
