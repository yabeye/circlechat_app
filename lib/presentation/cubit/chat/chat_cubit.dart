// lib/presentation/cubits/chat_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState());

  void toggleSelection(String chatId) {
    if (state.selectedChatIds.contains(chatId)) {
      emit(state.copyWith(
        selectedChatIds: List.from(state.selectedChatIds)..remove(chatId),
      ));
    } else {
      emit(state.copyWith(
        selectedChatIds: List.from(state.selectedChatIds)..add(chatId),
      ));
    }
  }

  void clearSelection() {
    emit(state.copyWith(selectedChatIds: []));
  }
}
