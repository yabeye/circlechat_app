part of 'message_input_cubit.dart';

sealed class MessageInputState extends Equatable {
  const MessageInputState({this.pendingFiles = const {}});
  final Map<String, List<File>> pendingFiles;

  @override
  List<Object?> get props => [pendingFiles];
}

final class MessageInputInitial extends MessageInputState {
  const MessageInputInitial({super.pendingFiles});
}

final class MessageInputLoading extends MessageInputState {
  const MessageInputLoading({
    required this.pendingMessages,
    super.pendingFiles,
  });
  final List<MessageModel> pendingMessages;

  @override
  List<Object?> get props => [pendingMessages, pendingFiles];
}

final class MessageInputError extends MessageInputState {
  const MessageInputError({
    required this.error,
    super.pendingFiles,
  });
  final String error;

  @override
  List<Object?> get props => [error, pendingFiles];
}
