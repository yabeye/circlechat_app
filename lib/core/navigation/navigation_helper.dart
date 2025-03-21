import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  /// Navigates to a specified route, optionally replacing the current route
  /// and passing parameters.
  static void navigateTo(
    BuildContext context,
    String routeName, {
    Map<String, String> params = const {},
    bool replace = false,
  }) {
    String path = routeName;
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        path = path.replaceAll(':$key', value);
      });
    }
    if (replace) {
      Navigator.pushReplacementNamed(context, routeName);
    } else {
      context.go(path);
    }
  }
}
