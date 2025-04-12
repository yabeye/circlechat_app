import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class ImageUtils {
  static final ImagePicker _picker = ImagePicker();

  /// Picks a single image from the device's gallery.
  ///
  /// Returns a `File` object representing the selected image, or
  /// `null` if no image was selected.
  static Future<File?> pickImage({
    ImageSource? source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    final XFile? pickedFile = await _picker.pickImage(
      // Note: even if source is passed, the method always uses gallery
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
      requestFullMetadata: requestFullMetadata,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }

  /// Picks multiple images from the device's gallery.
  ///
  /// Returns a `List<File>` object containing the selected images, or
  /// `null` if no images were selected.
  static Future<List<File>?> pickImages({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    int? limit,
    bool requestFullMetadata = true,
  }) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      limit: limit,
      requestFullMetadata: requestFullMetadata,
    );
    return pickedFiles.map((e) => File(e.path)).toList();
  }

  static Future<ui.Image> getImageDimensions(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }
}
