import 'package:wajeed/features/auth/data/models/user_model.dart';
import 'package:wajeed/features/auth/domain/entites/user.dart';

extension AuthMappers on UserModel {
  USer get toEntity => USer(
        id: id,
        name: name,
        phone: phone,
        role: role,
      );
}
