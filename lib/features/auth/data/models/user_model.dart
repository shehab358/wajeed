import 'package:wajeed/features/auth/domain/entites/user.dart';

class UserModel extends USer {
  const UserModel({
    required super.isAdmin,
    required super.id,
    required super.name,
    required super.phone,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'isAdmin': isAdmin,
      };
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          isAdmin: json['isAdmin'],
          id: json['id'],
          name: json['name'],
          phone: json['phone'],
        );
}
