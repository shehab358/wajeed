import 'package:wajeed/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRemoteDataSource {
  CollectionReference<UserModel> getUsersCollection();
  Future<UserModel> register(
    String phone,
    String password,
    String name,
  );
  Future<UserModel> login(String phone, String password);
  Future<void> forgetPassword(String phone);
  Future<void> logout();
}
