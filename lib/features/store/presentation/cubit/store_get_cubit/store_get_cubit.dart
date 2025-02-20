import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';
import 'package:wajeed/features/store/domain/use_case/get_store.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_states.dart';

@lazySingleton
class StoreGetCubit extends Cubit<StoreGetStates> {
  StoreGetCubit(this._getStore) : super(StoreGetStatesInitial());
  final GetStore _getStore;
  Store? userStore;

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
}
