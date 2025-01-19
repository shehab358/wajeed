import 'package:equatable/equatable.dart';

class USer extends Equatable {
  final String id;
  final String name;
  final String phone;
  const USer({
    required this.id,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, name, phone];
}
