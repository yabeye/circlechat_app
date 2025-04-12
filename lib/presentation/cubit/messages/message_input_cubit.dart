import 'dart:async';

import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_input_state.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit() : super(MessageInputInitial());

  final _firebaseService = FirebaseService();

  Future<void> sendMessage({
    required MessageModel message,
    String? chatId,
  }) async {
    try {
      if (state is MessageInputLoading) {
        final preMessages = [
          ...(state as MessageInputLoading).pendingMessages,
        ]..add(message);
        emit(MessageInputLoading(preMessages));
      } else {
        emit(MessageInputLoading([message]));
      }

      await _firebaseService.sendMessage(
        chatId ?? '',
        message,
      );

      final currentMessages = List<MessageModel>.from(
        (state as MessageInputLoading).pendingMessages,
      )..removeWhere((e) => e.id == message.id);

      if (currentMessages.isEmpty) {
        emit(MessageInputInitial());
      } else {
        emit(MessageInputLoading([...currentMessages]));
      }
    } catch (e) {
      emit(MessageInputError(e.toString()));
      rethrow;
    }
  }
}
