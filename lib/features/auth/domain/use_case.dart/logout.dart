import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/auth/domain/repository/auth_repositoy.dart';

@singleton
class Logout {
  final AuthRepository _authRepostitory;

  Logout(this._authRepostitory);
  Future<Either<Failure, void>> call() async => await _authRepostitory.logut();
}
