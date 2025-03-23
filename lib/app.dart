import 'package:circlechat_app/presentation/cubit/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/presentation/cubit/theme/theme_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/enums/theme_enum.dart';
import 'core/theme/app_theme.dart';
import 'presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/scheduler.dart';

class CirlceChatApp extends StatelessWidget {
  const CirlceChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(getIt()),
        ),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(
            getIt(),
            context.read<AuthCubit>(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          ThemeData themeData;

          switch (state.selectedTheme) {
            case AppTheme.light:
              themeData = lightTheme;
              break;
            case AppTheme.dark:
              themeData = darkTheme;
              break;
            case AppTheme.system: // (default)
              var brightness = SchedulerBinding
                  .instance.platformDispatcher.platformBrightness;
              themeData =
                  brightness == Brightness.dark ? darkTheme : lightTheme;
          }

          return ScreenUtilInit(builder: (context, _) {
            return MaterialApp.router(
              title: 'CircleChat',
              debugShowCheckedModeBanner: false,
              theme: themeData,
              routerConfig: AppRouter.router,
            );
          });
        },
      ),
    );
  }
}
