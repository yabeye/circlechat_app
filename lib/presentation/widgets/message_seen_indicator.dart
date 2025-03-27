import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MessageSeenIndicator extends StatelessWidget {
  const MessageSeenIndicator({
    super.key,
    required this.isSeen,
  });

  final bool isSeen;

  @override
  Widget build(BuildContext context) {
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
}
