part of 'auth_cubit.dart';

abstract class AuthState {
  AuthState(this.phoneNumber);
  final PhoneNumber? phoneNumber;
}

class AuthInitial extends AuthState {
  AuthInitial(super.phoneNumber);
}

class AuthInProgress extends AuthState {
  AuthInProgress(super.phoneNumber);
}

class AuthOTPCodeSent extends AuthState {
  AuthOTPCodeSent(super.phoneNumber, this.verificationId);
  final String verificationId;
}

class Authenticated extends AuthState {
  Authenticated(super.phoneNumber, this.user);

  final User? user;
}

class AuthFailure extends AuthState {
  AuthFailure(super.phoneNumber, this.message);

  final String message;
}

class AuthPhoneNumberChanged extends AuthState {
  AuthPhoneNumberChanged(super.phoneNumber);
}
