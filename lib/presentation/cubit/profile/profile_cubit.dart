import 'dart:io';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circlechat_app/services/logging_service.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/services/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._authCubit)
      : _logger = getIt<LoggingService>(),
        super(ProfileInitial());

  final AuthCubit _authCubit;
  final LoggingService _logger;
  final FirebaseService _firebaseService = getIt<FirebaseService>();

  Future<void> addUserDocument({
    required String name,
    required String about,
    File? profileImage,
  }) async {
    // validation //
    if ((name + about).isEmpty) {
      return;
    }

    emit(ProfileLoading());
    try {
      final User? user = _authCubit.state is Authenticated
          ? (_authCubit.state as Authenticated).user
          : null;

      if (user == null) {
        throw Exception('User is not authenticated');
      }

      String? profileImageUrl;

      if (profileImage != null) {
        profileImageUrl = await _uploadProfileImage(profileImage, user.uid);
      }

      await _firebaseService.addUserDocument(
        userId: user.uid,
        name: name,
        about: about,
        profileImageUrl: profileImageUrl,
        phoneNumber: user.phoneNumber,
      );

      emit(ProfileSuccess());
    } catch (e) {
      _logger.error('Error adding user document', error: e.toString());
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> updateUserDocument({
    String? name,
    String? about,
    File? profileImage,
  }) async {
    emit(ProfileLoading());
    try {
      final User? user = _authCubit.state is Authenticated
          ? (_authCubit.state as Authenticated).user
          : null;

      if (user == null) {
        throw Exception('User is not authenticated');
      }

      String? profileImageUrl;

      if (profileImage != null) {
        // Implement your image upload logic here
        // For example, using Firebase Storage
        // profileImageUrl = await _uploadImage(profileImage, user.uid);
      }

      Map<String, dynamic> updateData = {};
      if (name != null) {
        updateData['name'] = name;
      }
      if (about != null) {
        updateData['about'] = about;
      }
      if (profileImageUrl != null) {
        updateData['profileImageUrl'] = profileImageUrl;
      }

      await _firebaseService.updateUserDocument(
        userId: user.uid,
        updateData: updateData,
      );

      emit(ProfileSuccess());
    } catch (e) {
      _logger.error('Error updating user document', error: e.toString());
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<String?> _uploadProfileImage(File image, String userId) async {
    try {
      final originalFileName = path.basename(image.path);
      final fileExtension = path.extension(image.path);
      final uniqueId = const Uuid().v4();
      final uniqueFileName =
          '${path.withoutExtension(originalFileName)}_$uniqueId$fileExtension';

      final storagePath = 'profiles/$userId/$uniqueFileName';

      final imageUrl = await _firebaseService.uploadFile(
        file: image,
        storagePath: storagePath,
      );
      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }
}
