import 'package:go_router/go_router.dart';

class NavigationService {
  NavigationService(this.router);
  final GoRouter router;

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
