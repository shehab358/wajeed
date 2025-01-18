import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/auth/domain/entites/user.dart';
import 'package:wajeed/features/auth/domain/repository/auth_repositoy.dart';

@singleton
class Login {
  final AuthRepository _authRepostitory;

  Login(this._authRepostitory);
  Future<Either<Failure, USer>> call(String email, String password) async =>
      await _authRepostitory.login(
        email,
        password,
      );
}
