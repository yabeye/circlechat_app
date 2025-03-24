import 'dart:async';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit() : super(ChatListInitial());

  final _firebaseService = FirebaseService();
  final _auth = FirebaseAuth.instance;
  StreamSubscription<List<ChatModel>>? _chatsSubscription;

  Future<void> loadChats() async {
    emit(ChatListLoading());
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      emit(ChatListError('User not authenticated'));
      return;
    }

    try {
      _chatsSubscription =
          _firebaseService.getChatsStream(userId).listen((chats) {
        emit(ChatListLoaded(chats));
      }, onError: (error) {
        emit(ChatListError(error.toString()));
      });
    } catch (e) {
      emit(ChatListError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
