part of 'app_contacts_cubit.dart';

abstract class AppContactsState {
  List<UserModel> get contacts => [];
}

class AppContactsInitial extends AppContactsState {}

class AppContactsLoading extends AppContactsState {
  AppContactsLoading({this.contacts = const []});

  @override
  final List<UserModel> contacts;
}

class AppContactsLoaded extends AppContactsState {
  AppContactsLoaded(this.contacts);

  @override
  final List<UserModel> contacts;
}

class AppContactsError extends AppContactsState {
  AppContactsError(this.error);
  final String error;
}
