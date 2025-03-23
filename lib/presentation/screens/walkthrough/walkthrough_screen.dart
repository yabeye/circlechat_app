import 'package:circlechat_app/core/constants/app_constants.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/core/navigation/navigation_helper.dart';
import 'package:circlechat_app/presentation/cubit/splash/splash_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:circlechat_app/services/logging_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalkthroughScreen extends StatelessWidget {
  const WalkthroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return OnBoardingSlider(
      finishButtonText: 'Start Messaging',
      onFinish: () async {
        try {
          await context.read<SplashCubit>().tickFirstTime();

          if (context.mounted) {
            NavigationHelper.navigateTo(
              context,
              AppRouter.phoneAuth,
              replaceAll: true,
            );
          }
        } catch (e) {
          getIt
              .get<LoggingService>()
              .error('WalkthroughScreen', error: e.toString());
        }
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: AppColors.primary,
      ),
      skipTextButton: Text(
        'Skip',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.grey[400] : Colors.grey,
              fontSize: 18,
            ),
      ),
      controllerColor: AppColors.primary,
      totalPage: 4,
      headerBackgroundColor:
          isDarkMode ? AppColors.backgroundDark : Colors.white,
      pageBackgroundColor: isDarkMode ? AppColors.backgroundDark : Colors.white,
      centerBackground: true,
      background: [
        const AppSvg(
          path: KIcons.logo,
          width: 400,
          height: 400,
          color: AppColors.primary,
        ),
        const Icon(Icons.access_alarm, size: 400, color: AppColors.primary),
        const Icon(Icons.access_time, size: 400, color: AppColors.primary),
        const Icon(Icons.done_all, size: 400, color: AppColors.primary),
      ],
      speed: 1.8,
      pageBodies: [
        const _WalkthroughPageBody(
          title: AppConstants.walkthroughTitle1,
          description: AppConstants.walkthroughDescription1,
        ),
        const _WalkthroughPageBody(
          title: AppConstants.walkthroughTitle2,
          description: AppConstants.walkthroughDescription2,
        ),
        const _WalkthroughPageBody(
          title: AppConstants.walkthroughTitle3,
          description: AppConstants.walkthroughDescription3,
        ),
        const _WalkthroughPageBody(
          title: AppConstants.walkthroughTitle4,
          description: AppConstants.walkthroughDescription4,
        ),
      ],
    );
  }
}

class _WalkthroughPageBody extends StatelessWidget {

  const _WalkthroughPageBody({
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Spacer(flex: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: isDarkMode ? Colors.grey[400] : Colors.grey,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
