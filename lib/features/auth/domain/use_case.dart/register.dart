import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/auth/domain/entites/user.dart';
import 'package:wajeed/features/auth/domain/repository/auth_repositoy.dart';

@singleton
class Register {
  final AuthRepository _authRepostitory;
  Register(this._authRepostitory);
  Future<Either<Failure, USer>> call(
          String email, String name, String password, String role) async =>
      await _authRepostitory.register(email, password, name, role);
}
