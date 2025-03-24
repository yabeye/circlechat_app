import 'dart:async';
import 'package:circlechat_app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_contacts_state.dart';

class AppContactsCubit extends Cubit<AppContactsState> {
  AppContactsCubit() : super(AppContactsInitial());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  List<UserModel> _contacts = [];

  Future<void> loadContacts({int limit = 10}) async {
    if (!_hasMore) return;

    emit(AppContactsLoading());
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      emit(AppContactsError('User not authenticated'));
      return;
    }

    Query<Map<String, dynamic>> query = _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .orderBy('name')
        .limit(limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    try {
      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
        final newContacts = snapshot.docs
            .map((doc) => UserModel(
                  name: doc['name'],
                  about: doc['about'],
                  phoneNumber: doc['phoneNumber'],
                  profileImageUrl: doc['profileImageUrl'],
                  uid: doc.id,
                ))
            .toList();
        _contacts.addAll(newContacts);
        _hasMore = snapshot.docs.length == limit;
        emit(AppContactsLoaded(_contacts));
      } else {
        _hasMore = false;
        if (_contacts.isEmpty) {
          emit(AppContactsLoaded([]));
        } else {
          emit(AppContactsLoaded(_contacts));
        }
      }
    } catch (e) {
      emit(AppContactsError(e.toString()));
    }
  }

  void reset() {
    _lastDocument = null;
    _hasMore = true;
    _contacts = [];
  }
}
