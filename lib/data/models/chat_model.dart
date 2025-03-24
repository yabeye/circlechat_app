import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  ChatModel({
    this.id,
    this.type,
    this.participants = const [],
    this.participantUsers = const [],
    this.lastMessageTimestamp,
    this.text,
    this.lastMessageType,
    this.lastMessageSenderId,
    this.name,
    this.isSeen = false,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return ChatModel(
      id: json['id'] as String? ?? id,
      type: json['type'] != null ? ChatType.values.byName(json['type']) : null,
      participants: List<String>.from(json['participants'] ?? []),
      participantUsers: json['participantUsers'] != null
          ? (json['participantUsers'] as List<dynamic>)
              .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
      lastMessageTimestamp: json['lastMessageTimestamp'] is Timestamp
          ? (json['lastMessageTimestamp'] as Timestamp).toDate()
          : null,
      text: json['text'] as String?,
      lastMessageType: MessageType.values.byName(json['lastMessageType']),
      lastMessageSenderId: json['lastMessageSenderId'] as String?,
      name: json['name'] as String?,
      isSeen: json['isSeen'] as bool? ?? false,
    );
  }

  final String? id;
  final ChatType? type;
  final List<String> participants;
  final List<UserModel> participantUsers;
  final DateTime? lastMessageTimestamp;
  final String? text;
  final MessageType? lastMessageType;
  final String? lastMessageSenderId;
  final String? name;
  final bool isSeen;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type?.name,
      'participants': participants,
      'participantUsers':
          participantUsers.map((user) => user.toJson()).toList(),
      'lastMessageTimestamp': lastMessageTimestamp != null
          ? Timestamp.fromDate(lastMessageTimestamp!)
          : null,
      'text': text,
      'lastMessageType': lastMessageType?.name,
      'lastMessageSenderId': lastMessageSenderId,
      'name': name,
      'isSeen': isSeen,
    };
  }

  bool get isGroup => type == ChatType.group || type == ChatType.community;
  bool get isPinned => false;
}

class MessageModel {
  MessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.type,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      timestamp: json['timestamp'] as Timestamp,
      type: MessageType.values.byName(json['type']),
    );
  }

  final String id;
  final String senderId;
  final String text;
  final Timestamp timestamp;
  final MessageType type;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'type': type.name,
    };
  }
}
