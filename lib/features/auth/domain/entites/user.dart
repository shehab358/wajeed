import 'package:equatable/equatable.dart';

class USer extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String role;

  const USer(
    {
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, phone, role];
}
