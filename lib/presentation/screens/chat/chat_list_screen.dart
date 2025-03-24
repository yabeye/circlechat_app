import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/presentation/cubit/chat/chat_cubit.dart';
import 'package:circlechat_app/presentation/cubit/chat/chat_list_cubit.dart';
import 'package:circlechat_app/presentation/screens/chat/chat_app_bar.dart';
import 'package:circlechat_app/presentation/screens/chat/chat_list_tile.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_scaffold.dart';
import 'package:circlechat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  ChatListScreenState createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, chatState) {
          bool isSelecting = chatState.selectedChatIds.isNotEmpty;

          return AppScaffold(
            appBar: isSelecting
                ? const ChatSelectingAppBar()
                : const ChatMainAppBar(),
            body: BlocBuilder<ChatListCubit, ChatListState>(
              builder: (context, state) {
                if (state is ChatListInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ChatListLoaded) {
                  final chatData = state.chats;
                  return ListView.builder(
                    itemCount: chatData.length,
                    itemBuilder: (context, index) {
                      return ChatListTile(
                        chatModel: chatData[index],
                        onSelectChanged: (isSelected) {
                          context
                              .read<ChatCubit>()
                              .toggleSelection(chatData[index].id ?? '');
                        },
                        isSelected: chatState.selectedChatIds
                            .contains(chatData[index].id),
                        onTap: () {
                          if (isSelecting) {
                            context
                                .read<ChatCubit>()
                                .toggleSelection(chatData[index].id ?? '');
                          } else {
                            // TODO: Navigate to chat details screen
                          }
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            floatingActionButton: isSelecting
                ? null
                : FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      getIt.get<NavigationService>().pushNamed(
                            AppRouter.newChat,
                          );
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
