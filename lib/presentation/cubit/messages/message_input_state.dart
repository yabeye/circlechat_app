part of 'message_input_cubit.dart';

sealed class MessageInputState extends Equatable {
  const MessageInputState();

  @override
  List<Object> get props => [];
}

final class MessageInputInitial extends MessageInputState {}

final class MessageInputLoading extends MessageInputState {
  const MessageInputLoading(this.pendingMessages);

  final List<MessageModel> pendingMessages;

  @override
  List<Object> get props => [pendingMessages];
}

final class MessageInputError extends MessageInputState {
  const MessageInputError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
