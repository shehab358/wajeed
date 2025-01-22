import 'package:wajeed/features/category/data/models/category_model.dart';
import 'package:wajeed/features/category/domain/entities/category.dart';

extension CategoryMapper on CategoryModel {
  Category get toEntity => Category(
        name: name,
        id,
      );
}
