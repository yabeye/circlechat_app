import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:circlechat_app/app.dart';
import 'package:circlechat_app/app_observer.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // For App Check
  await FirebaseAppCheck.instance.activate(
    // Replace with AndroidProvider.debug or AndroidProvider.playIntegrity
    androidProvider: AndroidProvider.debug,
    // Replace with AppleProvider.debug or AppleProvider.deviceCheck
    appleProvider: AppleProvider.debug,
  );

  await setupLocator();

  Bloc.observer = AppObserver();

  // Set preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const CirlceChatApp());
  });
}
