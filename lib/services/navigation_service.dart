// lib/services/navigation_service.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GoRouter router;

  NavigationService(this.router);

  void navigateTo(String routeName,
      {Map<String, String> params = const {}, Object? extra}) {
    String path = routeName;
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        path = path.replaceAll(':$key', value);
      });
    }
    router.go(path, extra: extra);
  }

  void pushNamed(String routeName,
      {Map<String, String> params = const {}, Object? extra}) {
    String path = routeName;
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        path = path.replaceAll(':$key', value);
      });
    }
    router.push(path, extra: extra);
  }

  void goBack() {
    router.pop();
  }

  // Add other navigation methods as needed
}
