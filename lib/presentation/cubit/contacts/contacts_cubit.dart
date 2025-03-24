import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());

  Future<void> loadContacts() async {
    emit(ContactsLoading());
    try {
      if (await FlutterContacts.requestPermission()) {
        final contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
        emit(ContactsLoaded(contacts));
      } else {
        emit(ContactsPermissionDenied());
      }
    } catch (e) {
      emit(ContactsError(e.toString()));
    }
  }
}
