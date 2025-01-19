import 'package:wajeed/features/auth/domain/entites/user.dart';

class UserModel extends USer {
  const UserModel({
    required super.role,
    required super.id,
    required super.name,
    required super.phone,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'role': role,
      };
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          role: json['role'],
          id: json['id'],
          name: json['name'],
          phone: json['phone'],
        );
}
