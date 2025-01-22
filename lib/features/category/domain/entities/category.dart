import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  final String name;
  String id;

  Category(
    this.id, {
    required this.name,
  });

  @override
  List<Object?> get props => [name, id];
}
