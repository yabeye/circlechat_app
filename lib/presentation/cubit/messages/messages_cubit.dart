import 'dart:async';
import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  final _firebaseService = FirebaseService();
  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  Future<void> loadMessages(ChatModel chat, {Function? syncChatSeen}) async {
    emit(MessagesLoading());

    try {
      _messagesSubscription =
          _firebaseService.getMessagesStream(chat.id ?? '').listen(
        (messages) {
          emit(MessagesLoaded(chat, messages));
          syncChatSeen?.call();
          if (chat.status != MessageStatus.seen) {}
        },
        onError: (error) {
          emit(MessagesError(error.toString()));
        },
      );
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
