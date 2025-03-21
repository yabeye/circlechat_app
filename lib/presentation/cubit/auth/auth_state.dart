part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  AuthLoading(this.phoneNumber);
  final PhoneNumber? phoneNumber;
}

class AuthSuccess extends AuthState {
  AuthSuccess(this.user);

  final User user;
}

class AuthError extends AuthState {
  AuthError(this.message);

  final String message;
}

class VerificationCodeSent extends AuthState {
  final String verificationId;

  VerificationCodeSent(this.verificationId);
}

class PhoneNumberChanged extends AuthState {
  PhoneNumberChanged(this.phoneNumber);
  final PhoneNumber phoneNumber;
}
