import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';

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
          widget.onSelectChanged!(!isSelected!);
        }
      },
      child: Container(
        color: isSelected ? AppColors.selectIndicator : Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.globalPadding,
          ),
          minLeadingWidth: 8,
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              widget.chatModel.isGroup ?? false
                  ? KIcons.defaultGroupProfilePic()
                  : KIcons.defaultProfilePic(),
              Positioned(
                bottom: 0,
                right: 0,
                child: isSelected
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColors.selectIndicator, width: 2),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.check_outlined,
                            size: 18,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
          title: Text(
            widget.chatModel.chatName ?? '',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
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
                            color:
                                isSeen ? AppColors.seenIndicator : Colors.grey,
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
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis, // Add overflow handling
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
      ),
    );
  }
}
