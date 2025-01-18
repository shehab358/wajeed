import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/core/error/failure.dart';
import 'package:wajeed/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:wajeed/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:wajeed/features/auth/data/mappers/user_mappers.dart';
import 'package:wajeed/features/auth/domain/entites/user.dart';
import 'package:wajeed/features/auth/domain/repository/auth_repositoy.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<Either<Failure, List<USer>>> getUsersCollection() async {
    try {
      final collectionReference = _authRemoteDataSource.getUsersCollection();

      final usersQuerySnapshot = await collectionReference.get();

      final users = usersQuerySnapshot.docs.map((docSnapshot) {
        return docSnapshot.data().toEntity;
      }).toList();

      return right(users);
    } on AppException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Failed to fetch users: $e'));
    }
  }

  @override
  Future<Either<Failure, USer>> register(
      String phone, String password, String name) async {
    try {
      final userModel =
          await _authRemoteDataSource.register(phone, password, name);
      final user = userModel.toEntity;
      return Right(user);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, USer>> login(String phone, String password) async {
    try {
      final userModel = await _authRemoteDataSource.login(phone, password);
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final token = firebaseUser!.getIdToken().toString();
      await _authLocalDataSource.cacheToken(token);
      final user = userModel.toEntity;
      return Right(user);
    } on AppException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logut() async {
    try {
      await _authRemoteDataSource.logout();
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String phone) async {
    try {
      await _authRemoteDataSource.forgetPassword(phone);
      return const Right(null);
    } on RemoteException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
