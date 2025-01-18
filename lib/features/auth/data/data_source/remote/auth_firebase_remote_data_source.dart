
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:wajeed/features/auth/data/models/user_model.dart';

@Singleton(as: AuthRemoteDataSource)
class AuthFirebaseRemoteDataSource implements AuthRemoteDataSource {
  @override
  CollectionReference<UserModel> getUsersCollection() {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) =>
                UserModel.fromJson(docSnapshot.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        message = e.code;
      }
      throw RemoteException(
        message ?? 'An error occured',
      );
    }
  }

  @override
  Future<UserModel> register(String phone, String password, String name) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '$phone@example.com',
        password: password,
      );

      UserModel user = UserModel(
        id: credential.user!.uid,
        name: name,
        phone: phone,
      );

      CollectionReference<UserModel> usersCollection = getUsersCollection();
      await usersCollection.doc(user.id).set(user);

      return user;
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        if (e.code == 'email-already-in-use') {
          message = 'This email is already in use. Please try another.';
        } else if (e.code == 'weak-password') {
          message = 'Password is too weak.';
        } else {
          message = 'Registration failed. Please try again.';
        }
      }

      throw RemoteException(message ?? 'An error occured signning up');
    }
  }

  @override
  Future<UserModel> login(String phone, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '$phone@example.com',
        password: password,
      );
      User? firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('Authentication failed: No user found.');
      }
      CollectionReference<UserModel> usersCollection = getUsersCollection();

      DocumentSnapshot<UserModel> documentSnapshot =
          await usersCollection.doc(firebaseUser.uid).get();
      return documentSnapshot.data()!;
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        if (e.code == 'wrong-password') {
          message = 'Incorrect password. Please try again.';
        } else if (e.code == 'user-not-found') {
          message = 'No user found with this email.';
        } else if (e.code == 'invalid-email') {
          message = 'Invalid email address.';
        } else {
          message = 'Login failed. Please try again.';
        }
      }
      throw RemoteException(message ?? 'An error occured logging in');
    }
  }

  @override
  Future<void> logout() {
    try {
      return FirebaseAuth.instance.signOut();
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        message = e.code;
      }
      throw RemoteException(message ?? 'An error occured signning out');
    }
  }

  @override
  Future<void> forgetPassword(String phone) {
    try {
      return FirebaseAuth.instance.sendPasswordResetEmail(email: '$phone@example.com');
    } catch (e) {
      String? message;
      if (e is FirebaseException) {
        message = e.code;
      }
      throw RemoteException(
        message ?? 'An error occured resetting password',
      );
    }
  }
}
