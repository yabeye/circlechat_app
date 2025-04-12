import 'dart:async';
import 'package:circlechat_app/core/enums/chat_enums.dart';
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
        syncChatDelivered();
      }, onError: (error) {
        emit(ChatListError(error.toString()));
      });
    } catch (e) {
      emit(ChatListError(e.toString()));
    }
  }

  Future<void> syncChatDelivered() async {
    final myId = _auth.currentUser?.uid;
    if (state is ChatListLoaded) {
      final allUnDelivered = (state as ChatListLoaded).chats.where((e) =>
          (e.lastMessageSenderId != myId) &&
          (e.status?.delivered.containsKey(myId) ?? false));

      _firebaseService.updateChatStatusToDelivered(
        allUnDelivered.map((e) => e.id ?? '-').toSet().toList(),
      );
    }
  }

  Future<void> syncChatLastOpened(chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      emit(ChatListError('User not authenticated'));
      return;
    }

    if (state is ChatListLoaded) {
      try {
        ChatModel chat =
            (state as ChatListLoaded).chats.firstWhere((e) => e.id == chatId);

        if (chat.lastMessageSenderId != userId) {
          return;
        }

        _firebaseService
            .updateChatSeen(
              chat,
              MessageStatus.delivered,
              userId,
            )
            .catchError((e) {});
      } catch (_) {
        // unable to sync //
      }
    }
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
