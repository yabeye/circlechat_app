import 'package:circlechat_app/core/constants/app_constants.dart';
import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/services/local_storage_service.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:circlechat_app/services/navigation_service.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._firebaseService, this._authCubit)
      : _navigationService = getIt<NavigationService>(),
        super(SplashInitial());

  final FirebaseService _firebaseService;
  final NavigationService _navigationService;
  final AuthCubit _authCubit;

  Future<void> checkNavigation() async {
    final localStorageService = LocalStorageService();
    await localStorageService.init();

    final bool isFirstTime =
        localStorageService.getBool(LocalStorageKeys.isFirstTime) ?? true;

    if (isFirstTime) {
      await localStorageService.setBool(LocalStorageKeys.isFirstTime, false);
      _navigationService.navigateTo(AppRouter.walkthrough);
    } else {
      final user = _firebaseService.getCurrentUser();
      if (user == null) {
        _navigationService.navigateTo(AppRouter.phoneAuth);
      } else {
        _authCubit.emit(Authenticated(null, user));
        final userDocExists =
            await _firebaseService.userDocumentExists(user.uid);
        if (!userDocExists) {
          _navigationService.navigateTo(AppRouter.editProfile);
        } else {
          _navigationService.navigateTo(AppRouter.home);
        }
      }
    }
  }

  Future<void> tickFirstTime() async {
    final localStorageService = LocalStorageService();
    await localStorageService.init();
    await localStorageService.setBool(LocalStorageKeys.isFirstTime, false);
  }
}
