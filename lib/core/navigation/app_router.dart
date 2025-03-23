import 'package:circlechat_app/presentation/screens/auth/otp_screen.dart';
import 'package:circlechat_app/presentation/screens/auth/phone_auth_screen.dart';
import 'package:circlechat_app/presentation/screens/home/home_screen.dart';
import 'package:circlechat_app/presentation/screens/profile/edit_profile_screen.dart';
import 'package:circlechat_app/presentation/screens/settings/settings_screen.dart';
import 'package:circlechat_app/presentation/screens/walkthrough/walkthrough_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:circlechat_app/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String walkthrough = '/walkthrough';
  static const String phoneAuth = '/phone-auth';
  static const String otpAuth = '/otp-auth';
  static const String editProfile = '/edit-profile';
  static const String home = '/';
  static const String chat = '/chat/:chatId';
  static const String settings = '/settings';

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
      GoRoute(
        path: otpAuth,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsScreen(),
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
