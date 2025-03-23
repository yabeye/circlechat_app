import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/data/models/status_model.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListTile extends StatefulWidget {
  const ChatListTile({
    super.key,
    required this.chatModel,
    required this.onTap,
    this.onSelectChanged,
    this.isSelected = false,
  });

  final ChatModel chatModel;
  final Function(bool)? onSelectChanged;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  ChatListTileState createState() => ChatListTileState();
}

class ChatListTileState extends State<ChatListTile> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final isSeen = widget.chatModel.isSeen ?? true;

    return GestureDetector(
      onLongPress: () {
        if (widget.onSelectChanged != null) {
          widget.onSelectChanged!(!isSelected);
        }
      },
      child: ListTile(
        selected: isSelected,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.globalPadding,
        ),
        minLeadingWidth: 8,
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            ProfileAvatar(
              profileId: widget.chatModel.id,
              isGroup: widget.chatModel.isGroup ?? false,
              imageUrl:
                  'https://yt3.googleusercontent.com/2KbDSaZ6r5w_kXcG1LukeN3NfXnt7QxvgRCn-jmb3AalU7QR3rCRArQWNOBATRFNXMbspoYB=s900-c-k-c0x00ffffff-no-rj',
              status: (widget.chatModel.chatName != null &&
                      (int.tryParse(widget.chatModel.id) == 2 ||
                          int.tryParse(widget.chatModel.id) == 4))
                  ? StatusModel(
                      id: widget.chatModel.chatName!,
                      timestamp: DateTime.now(),
                      userId: widget.chatModel.chatName!,
                      imageUrl: KImages.currentUserDummyStatus,
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppColors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 22,
                        color: AppColors.black,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
        title: Row(
          children: [
            Text(
              widget.chatModel.chatName ?? '',
              style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(width: 4),
            if (widget.chatModel.isVerified ?? false)
              const Icon(
                Icons.verified,
                color: AppColors.blue,
                size: 16,
              ),
          ],
        ),
        horizontalTitleGap: 8,
        subtitle: Row(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (widget.chatModel.lastMessageUserId ==
                    context.read<AuthCubit>().userId) {
                  return SizedBox(
                    width: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 4),
                        Icon(
                          isSeen ? Icons.done_all : Icons.done,
                          size: 22,
                          color: isSeen ? AppColors.seenIndicator : Colors.grey,
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: Text(
                widget.chatModel.lastMessage ?? '',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).listTileTheme.subtitleTextStyle,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.chatModel.isPinned!)
              const Icon(
                Icons.push_pin,
                size: 16,
                color: Colors.grey,
              ),
            if (widget.chatModel.isPinned!) const SizedBox(width: 8),
            Text(
              widget.chatModel.messageTime ?? '',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: isSelected
            ? () {
                if (widget.onSelectChanged != null) {
                  widget.onSelectChanged!(!isSelected);
                }
              }
            : widget.onTap,
      ),
    );
  }
}
