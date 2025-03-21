part of 'auth_cubit.dart';

abstract class AuthState {
  AuthState(this.phoneNumber);
  final PhoneNumber? phoneNumber;
}

class AuthInitial extends AuthState {
  AuthInitial(super.phoneNumber);
}

class AuthLoading extends AuthState {
  AuthLoading(super.phoneNumber);
}

class AuthSuccess extends AuthState {
  AuthSuccess(super.phoneNumber, this.user);

  final User? user;
}

class AuthError extends AuthState {
  AuthError(super.phoneNumber, this.message);

  final String message;
}

class VerificationCodeSent extends AuthState {
  VerificationCodeSent(super.phoneNumber, this.verificationId);
  final String verificationId;
}

class AuthPhoneNumberChanged extends AuthState {
  AuthPhoneNumberChanged(super.phoneNumber);
}
