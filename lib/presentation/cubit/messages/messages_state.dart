// lib/presentation/cubits/messages/messages_state.dart
part of 'messages_cubit.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final ChatModel chat;
  final List<MessageModel> messages;

  MessagesLoaded(this.chat, this.messages);
}

class MessagesError extends MessagesState {
  final String error;

  MessagesError(this.error);
}
