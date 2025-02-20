import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/domain/use_case/update_store.dart';
import 'package:wajeed/features/store/presentation/cubit/update_store_cubit/update_store_states.dart';

@lazySingleton
class UpdateStoreCubit extends Cubit<UpdateStoreStates> {
  UpdateStoreCubit(this._updateStore) : super(UpdateStoreStatesInitial());
  final UpdateStore _updateStore;

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
}
