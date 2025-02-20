import 'package:wajeed/features/category/domain/entities/category.dart';

// ignore: must_be_immutable
class CategoryModel extends Category {
  CategoryModel(
    super.id, {
    required super.name,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
  CategoryModel.fromJson(Map<String, dynamic> json)
      : this(
          json['id'],
          name: json['name'],
        );
  CategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return CategoryModel(
      id ?? this.id,
      name: name ?? this.name,
    );
  }
}
