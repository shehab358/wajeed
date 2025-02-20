import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/domain/use_case/add_category.dart';
import 'package:wajeed/features/category/presentation/cubit/add_category_cubit/add_category_states.dart';

@lazySingleton
class AddCategoryCubit extends Cubit<AddCategoryStates> {
  AddCategoryCubit(
    this._addCategory,
  ) : super(AddCategoryInitial());
  final AddCategory _addCategory;

  Future<void> addCategory(CategoryModel category, String storeId) async {
    emit(AddCategoryLoading());
    final result = await _addCategory(category, storeId);
    result.fold(
      (failure) => emit(
        AddCategoryError(
          failure.message,
        ),
      ),
      (_) => emit(
        AddCategorySuccess(),
      ),
    );
  }
}
