abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterError extends AuthState {
  final String message;

  RegisterError(this.message);
}

class RegisterSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

class LoginSuccess extends AuthState {}

class LogoutLoading extends AuthState {}

class LogoutError extends AuthState {
  final String message;

  LogoutError(this.message);
}

class LogoutSuccess extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordError extends AuthState {
  final String message;

  ResetPasswordError(this.message);
}

class ResetPasswordSuccess extends AuthState {}
