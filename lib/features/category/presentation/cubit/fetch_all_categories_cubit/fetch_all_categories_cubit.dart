import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/domain/use_case/fetch_all_categories.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_all_categories_cubit/fetch_all_categories_states.dart';

@lazySingleton
class FetchAllCategoriesCubit extends Cubit<FetchAllCategoriesStates> {
  FetchAllCategoriesCubit(this._fetchAllCategories)
      : super(FetchAllCategoriesCubitInitial());
  final FetchAllCategories _fetchAllCategories;
  List<Category> categories = [];

  Future<void> fetchAllCategories(String storeId) async {
    emit(FetchAllCategoriesCubitLoading());
    final result = await _fetchAllCategories(storeId);
    result.fold(
      (failure) => emit(
        FetchAllCategoriesCubitErrorr(
          failure.message,
        ),
      ),
      (r) => emit(
        FetchAllCategoriesCubitSuccess(
          categories = r,
        ),
      ),
    );
  }
}
