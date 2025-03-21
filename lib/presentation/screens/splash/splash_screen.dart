import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    Color localTextColor = Colors.black;

    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSvg(
                  path: 'assets/icons/logo.svg',
                  height: 100,
                  width: 100,
                  color: localTextColor,
                ),
                const SizedBox(height: 20),
                Text(
                  'CircleChat',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: localTextColor), // Use theme
                ),
                const SizedBox(height: 10),
                Text(
                  'Connecting you with your circle.',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: localTextColor.withValues(alpha: 0.7),
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: localTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
