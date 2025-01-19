import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:wajeed/core/error/exceptions.dart';
import 'package:wajeed/features/auth/domain/use_case.dart/login.dart';
import 'package:wajeed/features/auth/domain/use_case.dart/logout.dart';
import 'package:wajeed/features/auth/domain/use_case.dart/register.dart';
import 'package:wajeed/features/auth/domain/use_case.dart/reset_password.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_states.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._register, this._login, this._logout, this._resetPassword)
      : super(AuthInitial());

  final Register _register;
  final Login _login;
  final Logout _logout;
  final ResetPassword _resetPassword;

  Future<void> register(
      String email, String name, String password, String role) async {
    emit(RegisterLoading());
    final result = await _register(
      email,
      name,
      password,
      role,
    );
    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (user) {
        emit(RegisterSuccess());
      },
    );
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await _login(email, password);
    result.fold(
      (failure) {
        log(
          failure.toString(),
        );
        emit(
          LoginError(
            failure.message,
          ),
        );
      },
      (user) {
        emit(LoginSuccess());
      },
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await _logout();
    result.fold(
      (failure) => emit(LogoutError(failure.message)),
      (_) {
        emit(LogoutSuccess());
      },
    );
  }

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoading());
    final result = await _resetPassword(email);
    result.fold(
      (failure) => emit(
        ResetPasswordError(
          failure.message,
        ),
      ),
      (_) {
        emit(
          ResetPasswordSuccess(),
        );
      },
    );
  }

  Future<String?> phoneParsing(
      {String? phone, String? countryCode, bool withCode = true}) async {
    PhoneNumber phoneParsed;
    try {
      phoneParsed = PhoneNumber.parse(
        phone!,
        callerCountry: IsoCode.values
            .where((element) => element.name == countryCode!.toUpperCase())
            .first,
        destinationCountry: countryCode == 'SA'
            ? IsoCode.SA
            : IsoCode.values
                .where((element) => element.name == countryCode!.toUpperCase())
                .first,
      );

      if (phoneParsed.isValid()) {
        return withCode == true ? phoneParsed.international : phoneParsed.nsn;
      } else {
        log('Phone number is invalid');
        // throw 'Invalid Phone Number';
        return null;
      }
    } on AppException {
      rethrow;
    }
  }
}
