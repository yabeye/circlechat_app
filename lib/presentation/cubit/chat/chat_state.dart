part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({this.selectedChatIds = const []});

  final List<String> selectedChatIds;

  ChatState copyWith({List<String>? selectedChatIds}) {
    return ChatState(selectedChatIds: selectedChatIds ?? this.selectedChatIds);
  }

  @override
  List<Object?> get props => [selectedChatIds];
}
