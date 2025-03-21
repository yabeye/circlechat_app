import 'package:circlechat_app/services/logging_service.dart';
import 'package:get_it/get_it.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:circlechat_app/services/local_storage_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerSingleton<LoggingService>(LoggingService())
    ..registerSingleton<LocalStorageService>(LocalStorageService())
    ..registerSingleton<FirebaseService>(FirebaseService());
}
