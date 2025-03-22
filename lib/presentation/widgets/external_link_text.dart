import 'package:flutter/material.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';

class ExternalLinkText extends StatelessWidget {
  const ExternalLinkText({
    required this.link,
    this.showArrow = false,
    super.key,
  });

  final String link;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        //TODO: Add logic here using url_launcher
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            link,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.externalLinkColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
          if (showArrow)
            const Icon(
              Icons.chevron_right,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
