import 'package:circlechat_app/core/errors.dart';
import 'package:circlechat_app/services/logging_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(FirebaseService firebaseService)
      : _firebaseService = firebaseService,
        _logger = getIt<LoggingService>(),
        super(AuthInitial(null));

  PhoneNumber? selectedPhoneNumber;

  final FirebaseService _firebaseService;
  final LoggingService _logger;

  String? get userId => 'my-dummy-uid';
  bool isMyId(String? userId) => userId == this.userId;

  bool _authSuccess = false;

  void setPhoneNumber(PhoneNumber phoneNumber) {
    selectedPhoneNumber = phoneNumber;
    emit(AuthPhoneNumberChanged(phoneNumber));
  }

  bool get isValidPhoneNumber =>
      (selectedPhoneNumber?.phoneNumber ?? '').length > 6;

  Future<void> sendVerificationCode() async {
    final String phoneNumber = selectedPhoneNumber?.phoneNumber ?? '';
    _logger.debug('Sending verification code to $phoneNumber');
    if (phoneNumber.isEmpty) {
      emit(
        AuthError(
          selectedPhoneNumber,
          'Please enter a valid phone number.',
        ),
      );
      return;
    }

    emit(AuthLoading(selectedPhoneNumber));
    _authSuccess = false;

    await signOut();
    try {
      await _firebaseService.sendVerificationCode(
        phoneNumber,
        (UserCredential userCredential) async {
          _authSuccess = true;
          emit(AuthSuccess(selectedPhoneNumber, userCredential.user));
        },
        (AppException e) {
          emit(AuthError(selectedPhoneNumber, e.message));
          _logger.error('Verification failed: ${e.message}', error: e);
        },
        (String verificationId, int? resendToken) {
          emit(VerificationCodeSent(selectedPhoneNumber, verificationId));
        },
        (String verificationId) {
          if (!_authSuccess) {
            // Check the flag before emitting error
            emit(AuthError(selectedPhoneNumber, 'Verification timeout.'));
            _logger.warning('Verification timeout: $verificationId');
          }
        },
      );
    } catch (e, stackTrace) {
      emit(AuthError(selectedPhoneNumber, 'An unexpected error occurred.'));
      _logger.error('Unexpected error sending verification code',
          error: e, stackTrace: stackTrace);
    }
  }

  Future<void> signInWithPhoneNumber(
    String smsCode,
  ) async {
    String verificationId = '';
    if (state is VerificationCodeSent) {
      verificationId = (state as VerificationCodeSent).verificationId;
    }

    _logger.debug('Signing in with PHONE: $selectedPhoneNumber, SMS:$smsCode');

    emit(AuthLoading(selectedPhoneNumber));
    _authSuccess = false;

    try {
      final userCredential = await _firebaseService.signInWithPhoneNumber(
        smsCode,
        verificationId,
      );
      _authSuccess = true;
      emit(AuthSuccess(selectedPhoneNumber, userCredential.user));
    } on AppException catch (e) {
      emit(AuthError(selectedPhoneNumber, e.message));
      _logger.error('Sign-in failed: ${e.message}', error: e);
    } catch (e, stackTrace) {
      emit(AuthError(selectedPhoneNumber, 'An unexpected error occurred.'));
      _logger.error(
        'Unexpected error signing in with phone number',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading(selectedPhoneNumber));
    try {
      await _firebaseService.signOut();
      emit(AuthInitial(selectedPhoneNumber));
    } on AppException catch (e) {
      emit(AuthError(selectedPhoneNumber, e.message));
      _logger.error('Sign-out failed: ${e.message}', error: e);
    } catch (e, stackTrace) {
      emit(AuthError(selectedPhoneNumber, 'Sign-out failed.'));
      _logger.error('Sign-out failed', error: e, stackTrace: stackTrace);
    }
  }

  User? getCurrentUser() {
    return _firebaseService.getCurrentUser();
  }
}
