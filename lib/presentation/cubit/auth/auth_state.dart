part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess(this.user);

  final User user;
}

class AuthError extends AuthState {
  AuthError(this.message);
  final String message;
}

class VerificationCodeSent extends AuthState {
  VerificationCodeSent(this.verificationId);

  final String verificationId;
}
