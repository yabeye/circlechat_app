import 'dart:io';

import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/cubit/chat/chat_list_cubit.dart';
import 'package:circlechat_app/presentation/cubit/messages/message_input_cubit.dart';
import 'package:circlechat_app/presentation/screens/messages/message_card.dart';
import 'package:circlechat_app/presentation/screens/messages/widgets/message_input.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_list_tile.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_scaffold.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circlechat_app/presentation/cubit/messages/messages_cubit.dart';
import 'package:circlechat_app/data/models/chat_model.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    required this.chatId,
    super.key,
  });
  final String chatId;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>();

    final chatCubit = context.read<ChatListCubit>();
    ChatModel? chat;

    if (chatCubit.state is ChatListLoaded) {
      chat = (chatCubit.state as ChatListLoaded)
          .chats
          .firstWhere((e) => e.id == widget.chatId);
    }

    if (chat == null) {
      // return a chat not found screen //
      return const Scaffold();
    }

    final myId = auth.userId;
    final otherUser = chat.participantUsers.firstWhere((e) => e.uid != myId);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MessagesCubit()
            ..loadMessages(
              chat!,
              syncChatSeen: () => chatCubit.syncChatLastOpened(
                chat?.id ?? '',
              ),
            ),
        ),
        BlocProvider(
          create: (context) => MessageInputCubit(),
        ),
      ],
      child: AppScaffold(
        backgroundImage:
            'https://img.freepik.com/free-vector/lineart-birds-pattern_23-2147495660.jpg?t=st=1743115328~exp=1743118928~hmac=49b895caa2cf821125cae7e09dc608599e82d7ff96e50b62183c83d5c763775f&w=740',
        appBar: AppBar(
          leadingWidth: 30,
          title: AppListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: ProfileAvatar(
              profileId: otherUser.uid,
            ),
            title: otherUser.name,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.videocam_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<MessageInputCubit, MessageInputState>(
                listener: (context, inputState) {
                  if (inputState is MessageInputLoading) {
                    _scrollToBottom();
                  }
                },
                builder: (context, inputState) {
                  final messageInputCubit = context.read<MessageInputCubit>();
                  List<MessageModel> pendingMessages = [];
                  if (inputState is MessageInputLoading) {
                    pendingMessages = inputState.pendingMessages;
                  }

                  return BlocBuilder<MessagesCubit, MessagesState>(
                    builder: (context, state) {
                      if (state is MessagesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MessagesLoaded) {
                        final messages = state.messages.toList()
                          ..addAll(
                            pendingMessages,
                          );
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            List<File> pendingFiles = [];

                            if (inputState.pendingFiles
                                .containsKey(message.id)) {
                              pendingFiles =
                                  inputState.pendingFiles[message.id] ?? [];
                            }

                            if (pendingFiles.isNotEmpty) {
                              message.file = MessageFileModel(
                                fileName:
                                    pendingFiles.first.path.split('/').last,
                                fileUrl: pendingFiles.first.path,
                              );
                            }

                            return MessageCard(
                              chat: chat!,
                              message: message,
                            );
                          },
                        );
                      } else if (state is MessagesError) {
                        return Center(child: Text('Error: ${state.error}'));
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            ),
            MessageInput(
              chatId: widget.chatId,
              senderId: auth.userId ?? '',
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
