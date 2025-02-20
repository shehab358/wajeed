import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/category/domain/use_case/delete_category.dart';
import 'package:wajeed/features/category/presentation/cubit/delete_category_c/delete_category_states.dart';

@lazySingleton
class DeleteCategoryCubit extends Cubit<DeleteCategoryStates> {
  DeleteCategoryCubit(this._deleteCategory)
      : super(DeleteCategoryCubitInitial());
  final DeleteCategory _deleteCategory;
  Future<void> deleteCategory(String categoryName, String storeId) async {
    emit(DeleteCategoryCubitLoading());
    final result = await _deleteCategory(categoryName, storeId);
    result.fold(
      (failure) => emit(
        DeleteCategoryCubitErrorr(
          failure.message,
        ),
      ),
      (_) => emit(
        DeleteCategoryCubitSuccess(),
      ),
    );
  }
}
