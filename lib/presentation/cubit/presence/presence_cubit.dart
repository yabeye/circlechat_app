import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:firebase_database/firebase_database.dart';

part 'presence_state.dart';

class PresenceCubit extends Cubit<PresenceState> with WidgetsBindingObserver {
  PresenceCubit() : super(PresenceInitial()) {
    WidgetsBinding.instance.addObserver(this);
  }

  final _firebaseService = getIt<FirebaseService>();
  StreamSubscription<DatabaseEvent>? presenceSubscription;
  Timer? _presenceTimer;

  void setUserOnline(String userId) async {
    try {
      await _firebaseService.setUserPresence(userId, true, DateTime.now());
    } catch (e) {
      emit(PresenceError(e.toString()));
    }
  }

  void setUserOffline(String userId) async {
    try {
      await _firebaseService.setUserPresence(userId, false, DateTime.now());
    } catch (e) {
      emit(PresenceError(e.toString()));
    }
  }

  void startPresenceListener(String userId) {
    presenceSubscription =
        _firebaseService.getUserPresenceStream(userId).listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        if (data['isOnline'] == null || data['lastSeen'] == null) {
          return;
        }
        print('ALL DATA ${data}');
        final isOnline = data['isOnline'] as bool? ?? false;
        final lastSeen =
            DateTime.fromMillisecondsSinceEpoch(data['lastSeen'] as int);

        emit(PresenceUpdated(isOnline, lastSeen));
      }
    }, onError: (error) {
      emit(PresenceError(error.toString()));
    });
  }

  void startPresenceTimer() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    _presenceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (state is! PresenceBackground) {
        setUserOnline(userId);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    if (state == AppLifecycleState.resumed) {
      setUserOnline(userId);
      startPresenceTimer();
      emit(PresenceForeground());
    } else if (state == AppLifecycleState.paused) {
      setUserOffline(userId);
      _presenceTimer?.cancel();
      emit(PresenceBackground());
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    presenceSubscription?.cancel();
    _presenceTimer?.cancel();
    return super.close();
  }
}
