import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/core/utils/app_formatters.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
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
    final isSeen = widget.chatModel.isSeen;

    final myId = context.read<AuthCubit>().userId;
    // final myAccount =
    //     widget.chatModel.participantUsers.firstWhere((e) => e.uid == myId);
    final otherUser =
        widget.chatModel.participantUsers.firstWhere((e) => e.uid != myId);

    return GestureDetector(
      onLongPress: () {
        if (widget.onSelectChanged != null) {
          widget.onSelectChanged!(!isSelected);
        }
      },
      child: ListTile(
        selected: isSelected,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.bodyHorizontalPadding,
        ),
        // minLeadingWidth: 8,
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            ProfileAvatar(
              profileId: otherUser.uid,
              isGroup: widget.chatModel.isGroup,
              imageUrl: otherUser.profileImageUrl,
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
              otherUser.name,
              style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(width: 4),
            if (otherUser.isVerified)
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
                if (widget.chatModel.lastMessageSenderId == myId) {
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
                widget.chatModel.text ?? '',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).listTileTheme.subtitleTextStyle,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.chatModel.isPinned)
              const Icon(
                Icons.push_pin,
                size: 16,
                color: Colors.grey,
              ),
            if (widget.chatModel.isPinned) const SizedBox(width: 8),
            Text(
              widget.chatModel.lastMessageTimestamp == null
                  ? ''
                  : AppFormatters.formatChatDateTime(
                      widget.chatModel.lastMessageTimestamp!,
                    ),
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
