class DeleteCategoryStates {}

class DeleteCategoryCubitInitial extends DeleteCategoryStates {}

class DeleteCategoryCubitSuccess extends DeleteCategoryStates {}

class DeleteCategoryCubitLoading extends DeleteCategoryStates {}

class DeleteCategoryCubitErrorr extends DeleteCategoryStates {
  final String message;

  DeleteCategoryCubitErrorr(this.message);
}
