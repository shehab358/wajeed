import 'package:wajeed/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:wajeed/features/auth/domain/entites/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, List<USer>>> getUsersCollection();

  Future<Either<Failure, USer>> register(
    String phone,
    String password,
    String name,
  );
  Future<Either<Failure, USer>> login(
    String phone,
    String password,
  );
  Future<Either<Failure, void>> logut();
  Future<Either<Failure, void>> resetPassword(String phone);
}
