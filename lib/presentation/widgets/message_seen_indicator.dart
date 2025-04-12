import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:flutter/material.dart';

class MessageSeenIndicator extends StatelessWidget {
  const MessageSeenIndicator({
    super.key,
    required this.otherUserId,
    this.status,
  });

  final String otherUserId;
  final MessageStatusModel? status;

  IconData _getIcon() {
    if (status?.seen.containsKey(otherUserId) ?? false) {
      return Icons.done_all;
    }

    if (status?.delivered.containsKey(otherUserId) ?? false) {
      return Icons.done_all;
    }

    if (status?.summary == MessageStatus.sent) {
      return Icons.done;
    }

    if (status?.summary == MessageStatus.sending) {
      return Icons.access_time;
    }

    return Icons.error;
  }

  @override
  Widget build(BuildContext context) {
    final isSeen = status?.seen.containsKey(otherUserId) ?? false;

    return SizedBox(
      width: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 4),
          Icon(
            _getIcon(),
            size: 22,
            color: isSeen ? AppColors.seenIndicator : Colors.grey,
          ),
        ],
      ),
    );
  }
}
