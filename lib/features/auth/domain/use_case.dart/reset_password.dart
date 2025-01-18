import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/auth/domain/repository/auth_repositoy.dart';

@singleton
class ResetPassword {
  final AuthRepository _authRepostitory;

  ResetPassword(this._authRepostitory);
  Future<Either<Failure, void>> call(
    String email,
  ) async =>
      await _authRepostitory.resetPassword(
        email,
      );
}
