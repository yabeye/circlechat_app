part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {
  ProfileFailure(this.errorMessage);
  final String errorMessage;
}

class UserDataLoaded extends ProfileState {
  UserDataLoaded(this.userData);
  final UserModel userData;
}
