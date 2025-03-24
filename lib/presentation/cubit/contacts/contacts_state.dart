part of 'contacts_cubit.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  ContactsLoaded(this.contacts);

  final List<Contact> contacts;
}

class ContactsPermissionDenied extends ContactsState {}

class ContactsError extends ContactsState {
  ContactsError(this.error);
  final String error;
}
