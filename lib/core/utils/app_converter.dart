abstract class AppConverter {
  static String secondsToFormattedTime(int totalSeconds) {
    if (totalSeconds < 60) {
      return '00:${totalSeconds.toString().padLeft(2, '0')}';
    } else if (totalSeconds < 3600) {
      final minutes = totalSeconds ~/ 60;
      final seconds = totalSeconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      final hours = totalSeconds ~/ 3600;
      final minutes = (totalSeconds % 3600) ~/ 60;
      final seconds = totalSeconds % 60;
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  static String formatFileSize(int sizeInBytes) {
    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (sizeInBytes < mb) {
      final sizeInKb = sizeInBytes / kb;
      return '${sizeInKb.toStringAsFixed(2)} KB';
    } else if (sizeInBytes < gb) {
      final sizeInMb = sizeInBytes / mb;
      return '${sizeInMb.toStringAsFixed(2)} MB';
    } else {
      final sizeInGb = sizeInBytes / gb;
      return '${sizeInGb.toStringAsFixed(2)} GB';
    }
  }
}
