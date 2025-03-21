class AppException implements Exception {
  AppException(this.message, {this.description});

  final String message;
  final String? description;

  @override
  String toString() {
    return 'AppException: Message: $message, Description: ${description != null ? '($description)' : ''}';
  }
}
