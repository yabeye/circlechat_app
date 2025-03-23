import 'package:circlechat_app/core/constants/app_constants.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/presentation/cubit/splash/splash_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkNavigation();
  }

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
                  path: KIcons.logo,
                  height: 100,
                  width: 100,
                  color: localTextColor,
                ),
                const SizedBox(height: 20),
                Text(
                  AppConstants.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: localTextColor),
                ),
                const SizedBox(height: 10),
                Text(
                  AppConstants.appDescription,
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
