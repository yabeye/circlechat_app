import 'dart:io';

import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/core/utils/app_converter.dart';
import 'package:circlechat_app/core/utils/app_formatters.dart';
import 'package:circlechat_app/core/utils/http_utils.dart';
import 'package:circlechat_app/core/utils/image_utils.dart';
import 'package:circlechat_app/core/utils/size_utils.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:circlechat_app/presentation/widgets/message_seen_indicator.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'dart:ui' as ui;

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.chat,
    required this.message,
  });

  final ChatModel chat;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMe = message.senderId == FirebaseAuth.instance.currentUser?.uid;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe ? Colors.blue[100] : Colors.grey[300];
    final isNotMeAndGroup = !isMe && chat.type == ChatType.group;

    final myId = context.read<AuthCubit>().userId;

    final sender = chat.participantUsers.firstWhere((e) => e.uid != myId);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isNotMeAndGroup)
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8,
            ),
            child: ProfileAvatar(
              profileId: sender.uid,
              imageUrl: sender.profileImageUrl,
              width: 32,
              height: 32,
            ),
          ),
        Expanded(
          child: Align(
            alignment: alignment,
            child: Container(
              margin: EdgeInsets.only(
                left: isNotMeAndGroup ? 0 : 8,
                right: 4,
                top: 8,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color?.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (message.file != null) MessageFile(message: message),
                  MessageText(
                    message: message,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppFormatters.formatTimeAmPm(
                            message.timestamp!.toDate()),
                        style: textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      if (isMe)
                        MessageSeenIndicator(
                          otherUserId: myId ?? '-',
                          status: message.status,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageText extends StatefulWidget {
  const MessageText({
    required this.message,
    super.key,
  });
  final MessageModel message;

  @override
  State<MessageText> createState() => _MessageTextState();
}

class _MessageTextState extends State<MessageText> {
  PreviewData? _previewData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final message = widget.message;

    if (HttpUtils.containsValidUrl(message.text ?? '')) {
      return LinkPreview(
        enableAnimation: true,
        onPreviewDataFetched: (data) {
          setState(() {
            _previewData = data;
          });
        },
        previewData: _previewData,
        text: message.text ?? '',
        textStyle: textTheme.bodyMedium!.copyWith(
          fontSize: message.type == MessageType.emoji ? 32 : null,
        ),
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
      );
    }

    return Text(
      message.text ?? '',
      style: textTheme.bodyMedium!.copyWith(
        fontSize: message.type == MessageType.emoji ? 32 : null,
      ),
    );
  }
}

class MessageFile extends StatelessWidget {
  const MessageFile({super.key, required this.message});
  final MessageModel message;

  Widget _imagePreviewer(String imageUrl) {
    final isNetworkImage = imageUrl.startsWith('https');

    final imageAspectRatio =
        (message.file?.width == null && message.file?.height == null)
            ? 1
            : ((message.file!.width ?? 1) / (message.file!.height ?? 1));
    if (isNetworkImage) {
      return AspectRatio(
        aspectRatio: imageAspectRatio.toDouble(),
        child: AppCachedNetworkImage(
          imageUrl: imageUrl,
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }
    return FutureBuilder<ui.Image>(
      future: ImageUtils.getImageDimensions(File(imageUrl)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox.shrink();
        } else {
          final imageAspectRatio = snapshot.data!.width / snapshot.data!.height;
          return AspectRatio(
            aspectRatio: imageAspectRatio,
            child: AppImage(
              filePath: imageUrl,
              borderRadius: BorderRadius.circular(6),
              width: snapshot.data?.width.toDouble(),
              fit: BoxFit.fitWidth,
            ),
          );
        }
      },
    );
  }

  Widget _getWidget(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (message.type) {
      case MessageType.image:
        return Stack(
          children: [
            _imagePreviewer(message.file?.fileUrl ?? ''),
            _buildPending(),
          ],
        );
      case MessageType.video:
        return Stack(
          children: [
            _imagePreviewer(message.file?.coverImage ?? ''),
            Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryFade,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppConverter.secondsToFormattedTime(
                    message.file?.duration ?? 0,
                  ),
                  style: textTheme.bodySmall!.copyWith(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryFade,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            _buildPending(),
          ],
        );
      case MessageType.file:
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryFade,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryFade,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.file_copy_rounded,
                        ),
                      ),
                    ),
                    Text(
                      AppConverter.formatFileSize(message.file?.size ?? 0),
                      style: textTheme.labelSmall!.copyWith(),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    message.file?.fileName ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: _getWidget(context),
    );
  }

  _buildPending() {
    return (message.status?.summary == MessageStatus.sending)
        ? const Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
