class AddCategoryStates {}

class AddCategoryInitial extends AddCategoryStates {}

class AddCategoryLoading extends AddCategoryStates {}

class AddCategorySuccess extends AddCategoryStates {}

class AddCategoryError extends AddCategoryStates {
  final String message;
  AddCategoryError(this.message);
}
