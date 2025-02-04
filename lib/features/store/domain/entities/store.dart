import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Store extends Equatable {
  String id;
  final String name;
  final String tagline;
  final String userId;
  final String city;
  final String address;
  final double minimumOrderCost;
  final String paymentMethod;
  final String category;
  final bool isSales;

  Store({
    this.id = '',
    this.isSales = false,
    required this.name,
    required this.userId,
    required this.tagline,
    required this.city,
    required this.address,
    required this.minimumOrderCost,
    required this.paymentMethod,
    required this.category,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        userId,
        tagline,
        city,
        address,
        minimumOrderCost,
        paymentMethod,
        category,
        isSales,
      ];
}
