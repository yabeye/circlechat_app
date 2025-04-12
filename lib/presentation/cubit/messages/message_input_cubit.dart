import 'dart:async';
import 'dart:io';

import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/core/utils/image_utils.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

part 'message_input_state.dart';

class MessageInputCubit extends Cubit<MessageInputState> {
  MessageInputCubit() : super(const MessageInputInitial());

  final _firebaseService = FirebaseService();

  void addPendingFiles(String key, List<File> files) {
    final newMap = Map<String, List<File>>.from(state.pendingFiles);
    newMap.putIfAbsent(key, () => []).addAll(files);
    emit(_copyStateWith(pendingFiles: newMap));
  }

  void clearPendingFilesForKey(String key) {
    final newMap = Map<String, List<File>>.from(state.pendingFiles)
      ..remove(key);
    emit(_copyStateWith(pendingFiles: newMap));
  }

  Future<void> sendMessage({
    required MessageModel message,
    String? chatId,
    List<File> imageFiles = const [],
  }) async {
    try {
      final currentPending = state is MessageInputLoading
          ? List<MessageModel>.from(
              (state as MessageInputLoading).pendingMessages)
          : <MessageModel>[];
      emit(MessageInputLoading(
        pendingMessages: [...currentPending, message],
        pendingFiles: state.pendingFiles,
      ));

      // Handle file upload (first image only)
      if (imageFiles.isNotEmpty) {
        final img = await ImageUtils.getImageDimensions(imageFiles.first);
        print('Width: ${img.width}, Height: ${img.height}');

        final imageUrl = await _uploadChatFile(
          file: imageFiles.first,
          chatId: chatId ?? '',
          fileType: MessageType.image,
        );

        final messageFile = MessageFileModel(
          fileUrl: imageUrl!,
          fileName: path.basename(imageFiles.first.path),
          size: imageFiles.first.lengthSync(),
          width: img.width.toDouble(),
          height: img.height.toDouble(),
        );

        message
          ..type = MessageType.image
          ..file = messageFile;
      }

      await Future.delayed(
        const Duration(seconds: 3),
      );
      await _firebaseService.sendMessage(chatId ?? '', message);

      // temporary message clean up
      final updatedMessages = (state as MessageInputLoading)
          .pendingMessages
          .where((m) => m.id != message.id)
          .toList();
      clearPendingFilesForKey(message.id ?? '-');

      if (updatedMessages.isEmpty) {
        emit(MessageInputInitial(pendingFiles: state.pendingFiles));
      } else {
        emit(MessageInputLoading(
          pendingMessages: updatedMessages,
          pendingFiles: state.pendingFiles,
        ));
      }
    } catch (e) {
      emit(MessageInputError(
        error: e.toString(),
        pendingFiles: state.pendingFiles,
      ));
      rethrow;
    }
  }

  Future<String?> _uploadChatFile({
    required File file,
    required String chatId,
    required MessageType fileType,
  }) async {
    try {
      final originalFileName = path.basename(file.path);
      final extension = path.extension(file.path);
      final uniqueId = const Uuid().v4();
      final uniqueName =
          '${path.withoutExtension(originalFileName)}_$uniqueId$extension';
      final storagePath = 'chats/$chatId/${fileType.name}/$uniqueName';

      return await _firebaseService.uploadFile(
        file: file,
        storagePath: storagePath,
      );
    } catch (e) {
      rethrow;
    }
  }

  MessageInputState _copyStateWith({
    required Map<String, List<File>> pendingFiles,
  }) {
    final s = state;
    if (s is MessageInputInitial) {
      return MessageInputInitial(pendingFiles: pendingFiles);
    } else if (s is MessageInputLoading) {
      return MessageInputLoading(
        pendingMessages: s.pendingMessages,
        pendingFiles: pendingFiles,
      );
    } else if (s is MessageInputError) {
      return MessageInputError(
        error: s.error,
        pendingFiles: pendingFiles,
      );
    } else {
      return MessageInputInitial(pendingFiles: pendingFiles);
    }
  }
}
