// lib/presentation/cubit/auth/auth_cubit.dart
import 'package:circlechat_app/core/errors.dart';
import 'package:circlechat_app/services/logging_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:circlechat_app/core/locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(FirebaseService firebaseService)
      : _firebaseService = firebaseService,
        _logger = getIt<LoggingService>(),
        super(AuthInitial());

  final FirebaseService _firebaseService;
  final LoggingService _logger;

  Future<void> sendVerificationCode(String phoneNumber) async {
    emit(AuthLoading());
    try {
      await _firebaseService.sendVerificationCode(
        phoneNumber,
        (UserCredential userCredential) async {
          emit(AuthSuccess(userCredential.user!));
        },
        (AppException e) {
          emit(AuthError(e.message));
          _logger.error('Verification failed: ${e.message}', error: e);
        },
        (String verificationId, int? resendToken) {
          emit(VerificationCodeSent(verificationId));
        },
        (String verificationId) {
          emit(AuthError('Verification timeout.'));
          _logger.warning('Verification timeout: $verificationId');
        },
      );
    } catch (e, stackTrace) {
      emit(AuthError('An unexpected error occurred.'));
      _logger.error('Unexpected error sending verification code',
          error: e, stackTrace: stackTrace);
    }
  }

  Future<void> signInWithPhoneNumber(
    String smsCode,
    String verificationId,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseService.signInWithPhoneNumber(
        smsCode,
        verificationId,
      );
      emit(AuthSuccess(userCredential.user!));
    } on AppException catch (e) {
      emit(AuthError(e.message));
      _logger.error('Sign-in failed: ${e.message}', error: e);
    } catch (e, stackTrace) {
      emit(AuthError('An unexpected error occurred.'));
      _logger.error(
        'Unexpected error signing in with phone number',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _firebaseService.signOut();
      emit(AuthInitial());
    } on AppException catch (e) {
      emit(AuthError(e.message));
      _logger.error('Sign-out failed: ${e.message}', error: e);
    } catch (e, stackTrace) {
      emit(AuthError('Sign-out failed.'));
      _logger.error('Sign-out failed', error: e, stackTrace: stackTrace);
    }
  }

  User? getCurrentUser() {
    return _firebaseService.getCurrentUser();
  }
}
