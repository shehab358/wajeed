import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/category/domain/use_case/fetch_user_categories.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_states.dart';

@lazySingleton
class FetchUserCategoriesCubit extends Cubit<FetchUserCategoriesStates> {
  FetchUserCategoriesCubit(this._fetchUserCategories)
      : super(FetchUserCategoriesCubitInitial());
  final FetchUserCategories _fetchUserCategories;

  Future<void> fetchUserCategories(String storeId) async {
    emit(FetchUserCategoriesCubitLoading());
    final result = await _fetchUserCategories(storeId);
    result.fold(
      (failure) => emit(
        FetchUserCategoriesCubitErrorr(
          failure.message,
        ),
      ),
      (r) => emit(
        FetchUserCategoriesCubitSuccess(
          r,
        ),
      ),
    );
  }
}
