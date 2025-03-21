import 'package:circlechat_app/presentation/screens/auth/phone_auth_screen.dart';
import 'package:circlechat_app/presentation/screens/walkthrough/walkthrough_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:circlechat_app/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String walkthrough = '/walkthrough';
  static const String phoneAuth = '/phone-auth';
  static const String home = '/';
  static const String chat = '/chat/:chatId';

  static GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: walkthrough,
        builder: (context, state) => const WalkthroughScreen(),
      ),
      GoRoute(
        path: phoneAuth,
        builder: (context, state) => const PhoneAuthScreen(),
      ),
      // GoRoute(
      //   path: chatList,
      //   builder: (context, state) => ChatListScreen(),
      // ),
      // GoRoute(
      //   path: chat,
      //   builder: (context, state) {
      //     final chatId = state.params['chatId']!;
      //     return ChatScreen(chatId: chatId);
      //   },
      // ),

      // Add other routes here
    ],
  );
}
