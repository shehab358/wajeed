import 'package:wajeed/features/store/data/models/store_model.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';

extension StoreMapper on StoreModel {
  Store get toEntity => Store(
        name: name,
        userId: userId,
        tagline: tagline,
        city: city,
        address: address,
        minimumOrderCost: minimumOrderCost,
        paymentMethod: paymentMethod,
        category: category,
        isSales: isSales,
        id: id,
      );
}
