// Temporary model for status
class StatusModel {
  StatusModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.timestamp,
  });

  final String id;
  final String userId;
  final String imageUrl;
  final DateTime timestamp;
}
