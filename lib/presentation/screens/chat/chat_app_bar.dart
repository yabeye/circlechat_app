import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/core/navigation/navigation_helper.dart';
import 'package:circlechat_app/presentation/cubit/chat/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatMainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: AppSizes.globalPadding,
      titleTextStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 24,
      ),
      title: const Text(
        'CircleChat',
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search_sharp),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          offset: const Offset(0, kToolbarHeight * 0.2),
          onSelected: (String result) {
            switch (result) {
              case 'New Group':
                break;
              case 'New Community':
                break;
              case 'Starred Messages':
                break;
              case 'Settings':
                NavigationHelper.navigateTo(context, AppRouter.settings);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'New Group',
              child: Text('New Group'),
            ),
            const PopupMenuItem<String>(
              value: 'New Community',
              child: Text('New Community'),
            ),
            const PopupMenuItem<String>(
              value: 'Starred Messages',
              child: Text('Starred Messages'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
          ],
          icon: const Icon(Icons.more_vert_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ChatSelectingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ChatSelectingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final totalSelected = state.selectedChatIds.length;

        return AppBar(
          leading: IconButton(
            onPressed: context.read<ChatCubit>().clearSelection,
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(
            totalSelected.toString(),
          ),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.push_pin_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications_off_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.archive_outlined),
              onPressed: () {},
            ),
            PopupMenuButton<String>(
              position: PopupMenuPosition.under,
              offset: const Offset(0, kToolbarHeight * 0.2),
              onSelected: (String result) {
                switch (result) {
                  case 'New Group':
                    break;
                  case 'New Community':
                    break;
                  case 'Starred Messages':
                    break;
                  case 'Settings':
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Mark as unread',
                  child: Text('Mark as unread'),
                ),
                const PopupMenuItem<String>(
                  value: 'Select All',
                  child: Text('Select All'),
                ),
                const PopupMenuItem<String>(
                  value: 'Starred Messages',
                  child: Text('Lock Chats'),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: Text('Add to list'),
                ),
              ],
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
