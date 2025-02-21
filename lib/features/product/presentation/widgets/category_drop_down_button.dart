import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_cubit.dart';
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_states.dart';
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart';

class CategoryDropdown extends StatefulWidget {
  final Function(Category) onCategorySelected;

  const CategoryDropdown({super.key, required this.onCategorySelected});
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  Category? selectedCategory;
  final FetchUserCategoriesCubit _fetchUserCategoriesCubit =
      serviceLocator.get<FetchUserCategoriesCubit>();
  final StoreGetCubit _storeGetCubit = serviceLocator.get<StoreGetCubit>();

  @override
  void initState() {
    super.initState();
    _fetchStoreAndCategories();
  }

  void _fetchStoreAndCategories() async {
    await _storeGetCubit.getStore();
    final storeId = _storeGetCubit.userStore?.id;
    if (storeId != null) {
      _fetchUserCategoriesCubit.fetchUserCategories(storeId);
    } else {
      debugPrint('Store ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchUserCategoriesCubit, FetchUserCategoriesStates>(
      bloc: _fetchUserCategoriesCubit,
      builder: (context, state) {
        if (state is FetchUserCategoriesCubitLoading) {
          return const LoadingIndicator();
        } else if (state is FetchUserCategoriesCubitSuccess) {
          final categories = state.categories;
          return DropdownButton<Category>(
            value: selectedCategory,
            onChanged: (Category? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedCategory = newValue;
                });
                widget.onCategorySelected(newValue);
              }
            },
            items: categories.isNotEmpty
                ? categories
                    .map<DropdownMenuItem<Category>>((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList()
                : [], // Avoid passing null items
            hint: const Text("Select a Category"),
          );
        } else if (state is FetchUserCategoriesCubitErrorr) {
          return Text('Failed to load categories: ${state.message}');
        }
        return const SizedBox();
      },
    );
  }
}
