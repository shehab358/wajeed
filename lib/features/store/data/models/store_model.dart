import 'package:wajeed/features/store/domain/entities/store.dart';

// ignore: must_be_immutable
class StoreModel extends Store {
  StoreModel({
    super.id = '',
    super.isSales = 'false',
    required super.name,
    required super.userId,
    required super.tagline,
    required super.city,
    required super.address,
    required super.minimumOrderCost,
    required super.paymentMethod,
    required super.category,
  });

  @override
  set id(String newId) {
    super.id = newId;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userId': userId,
        'tagline': tagline,
        'city': city,
        'address': address,
        'minimumOrderCost': minimumOrderCost,
        'paymentMethod': paymentMethod,
        'category': category,
        'isSales': isSales,
      };

  StoreModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          userId: json['userId'],
          tagline: json['tagline'],
          city: json['city'],
          address: json['address'],
          minimumOrderCost: json['minimumOrderCost'],
          paymentMethod: json['paymentMethod'],
          category: json['category'],
          isSales: json['isSales'],
        );

  StoreModel copyWith({
    String? id,
    String? name,
    String? userId,
    String? tagline,
    String? city,
    String? address,
    double? minimumOrderCost,
    String? paymentMethod,
    String? category,
    String? isSales,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      tagline: tagline ?? this.tagline,
      city: city ?? this.city,
      address: address ?? this.address,
      minimumOrderCost: minimumOrderCost ?? this.minimumOrderCost,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      category: category ?? this.category,
      isSales: isSales ?? this.isSales,
    );
  }
}
