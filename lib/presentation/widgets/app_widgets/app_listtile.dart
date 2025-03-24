import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.onTap,
    this.trailing,
    this.contentPadding,
    this.horizontalTitleGap,
    this.verticalSpacing,
  });

  final Widget? leading;
  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final double? horizontalTitleGap;
  final double? verticalSpacing;

  @override
  Widget build(BuildContext context) {
    final tileTheme = Theme.of(context).listTileTheme;
    return ListTile(
      leading: leading,
      title: title != null
          ? Text(
              title ?? '',
              style: titleStyle ?? tileTheme.titleTextStyle,
              maxLines: 1,
            )
          : null,
      subtitle: subtitle != null
          ? Text(
              subtitle ?? '',
              style: subtitleStyle ?? tileTheme.subtitleTextStyle,
              maxLines: 2,
            )
          : null,
      onTap: onTap,
      trailing: trailing,
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
      minVerticalPadding: verticalSpacing,
      shape: const RoundedRectangleBorder(),
    );
  }
}
