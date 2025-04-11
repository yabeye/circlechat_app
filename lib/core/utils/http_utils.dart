abstract class HttpUtils {
  static bool containsValidUrl(String input) {
    final urlRegex = RegExp(
      r'((https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/\S*)?)',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(input);
  }
}
