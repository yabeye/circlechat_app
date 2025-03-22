import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/cubit/chat/chat_cubit.dart';
import 'package:circlechat_app/presentation/screens/chat/chat_app_bar.dart';
import 'package:circlechat_app/presentation/screens/chat/chat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  ChatListScreenState createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  List<String> _pinnedChatIds = [];
  List<ChatModel> chatData = [];

  @override
  void initState() {
    super.initState();
    chatData = List.generate(20, (index) {
      final id = const Uuid().v4();
      return ChatModel(
        id: id,
        chatName: index % 2 == 0 ? 'Group Chat $index' : 'Contact $index',
        lastMessage: 'Last message from chat $index',
        messageTime: '10:00 AM',
        isPinned: _pinnedChatIds.contains(id),
        isSeen: index % 4 == 0,
        isGroup: index % 3 == 0,
        lastMessageUserId: index % 3 == 0
            ? context.read<AuthCubit>().userId
            : const Uuid().v4(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          bool isSelecting = state.selectedChatIds.isNotEmpty;

          chatData.sort((a, b) {
            if (a.isPinned == true && b.isPinned == false) {
              return -1;
            } else if (a.isPinned == false && b.isPinned == true) {
              return 1;
            } else {
              return 0;
            }
          });

          return Scaffold(
            appBar: isSelecting
                ? const ChatSelectingAppBar()
                : const ChatMainAppBar(),
            body: ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                return ChatListTile(
                  chatModel: chatData[index],
                  onSelectChanged: (isSelected) {
                    context
                        .read<ChatCubit>()
                        .toggleSelection(chatData[index].id);
                  },
                  isSelected:
                      state.selectedChatIds.contains(chatData[index].id),
                  onTap: () {
                    if (isSelecting) {
                      context
                          .read<ChatCubit>()
                          .toggleSelection(chatData[index].id);
                    } else {
                      // TODO: Navigate to chat details screen
                    }
                  },
                );
              },
            ),
            floatingActionButton: isSelecting
                ? null
                : FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      // TODO: Navigate to new chat screen
                    },
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.maps_ugc_rounded,
                      color: AppColors.textLight,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
