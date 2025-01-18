import 'package:wajeed/features/auth/domain/entites/user.dart';

class UserModel extends USer {
  UserModel({
    required super.id,
    required super.name,
    required super.phone,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
      };
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          phone: json['phone'],
        );
}
