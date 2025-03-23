import 'package:flutter/material.dart';

abstract class ThemeUtils {
  static TextStyle chatListTileTitleTextStyle(BuildContext context) =>
      Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          );
}
