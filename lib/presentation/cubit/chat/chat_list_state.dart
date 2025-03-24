part of 'chat_list_cubit.dart';

abstract class ChatListState {}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  ChatListLoaded(this.chats);

  final List<ChatModel> chats;
}

class ChatListError extends ChatListState {
  ChatListError(this.error);
  final String error;
}
