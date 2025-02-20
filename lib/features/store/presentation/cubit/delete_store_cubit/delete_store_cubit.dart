import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/store/domain/use_case/delete_store.dart';
import 'package:wajeed/features/store/presentation/cubit/delete_store_cubit/delete_store_states.dart';

@lazySingleton
class DeleteStoreCubit extends Cubit<DeleteStoreStates> {
  DeleteStoreCubit(this._deleteStore) : super(DeleteStoreStatesInitial());

  final DeleteStore _deleteStore;
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
}
