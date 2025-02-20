import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';
import 'package:wajeed/features/store/domain/use_case/get_all_stores.dart';
import 'package:wajeed/features/store/presentation/cubit/all_stores_get_cubit/all_stores_get_states.dart';

@lazySingleton
class AllStoresGetCubit extends Cubit<AllStoresGetStates> {
  AllStoresGetCubit(
    this._getAllStores,
  ) : super(AllStoresGetStatesInitial());
  final GetAllStores _getAllStores;
  List<Store> stores = [];
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
}
