import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/cubit/chat/chat_list_cubit.dart';
import 'package:circlechat_app/presentation/cubit/presence/presence_cubit.dart';
import 'package:circlechat_app/services/logging_service.dart';
import 'package:circlechat_app/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:circlechat_app/services/local_storage_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final localStorageService = LocalStorageService();
  await localStorageService.init();

  getIt
    ..registerSingleton<LoggingService>(LoggingService())
    ..registerSingleton<LocalStorageService>(LocalStorageService())
    ..registerLazySingleton(() => NavigationService(AppRouter.router))
    ..registerSingleton<FirebaseService>(FirebaseService())
    ..registerSingleton<AuthCubit>(AuthCubit(FirebaseService()))
    ..registerSingleton<PresenceCubit>(PresenceCubit())
    ..registerSingleton<ChatListCubit>(ChatListCubit());
}
