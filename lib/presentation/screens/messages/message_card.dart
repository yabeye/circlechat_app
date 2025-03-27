import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/core/utils/app_converter.dart';
import 'package:circlechat_app/core/utils/app_formatters.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:circlechat_app/presentation/widgets/message_seen_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMe = message.senderId == FirebaseAuth.instance.currentUser?.uid;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe ? Colors.blue[100] : Colors.grey[300];

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (message.file != null) MessageFile(message: message),
            Text(
              message.text ?? '',
              style: textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppFormatters.formatTimeAmPm(message.timestamp!.toDate()),
                  style: textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                if (isMe)
                  MessageSeenIndicator(
                    isSeen: message.isSeen ?? false,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageFile extends StatelessWidget {
  const MessageFile({super.key, required this.message});
  final MessageModel message;

  Widget _imagePreviewer(String imageUrl) {
    return AppCachedNetworkImage(
      imageUrl: imageUrl,
      borderRadius: BorderRadius.circular(6),
    );
  }

  Widget _getWidget(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (message.type) {
      case MessageType.image:
        return _imagePreviewer(message.file?.fileName ?? '');
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
}
