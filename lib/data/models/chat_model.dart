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
              .map((item) => UserModel.fromJson(
                    item as Map<String, dynamic>,
                    id: item['uid'],
                  ))
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
    this.id,
    this.senderId,
    this.text,
    this.timestamp,
    this.type,
    this.file,
    this.isSeen = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return MessageModel(
      id: json['id'] as String? ?? id,
      senderId: json['senderId'] as String?,
      text: json['text'] as String?,
      timestamp: json['timestamp'] as Timestamp?,
      type: MessageType.values.byName(json['type']),
      file: json['file'] != null
          ? MessageFileModel.fromJson(json['file'] as Map<String, dynamic>)
          : null,
      isSeen: json['isSeen'] as bool? ?? false,
    );
  }

  final String? id;
  final String? senderId;
  final String? text;
  final Timestamp? timestamp;
  final MessageType? type;
  final MessageFileModel? file;
  final bool? isSeen;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'type': type?.name,
      'file': file,
      'isSeen': isSeen,
    };
  }
}

class MessageFileModel {
  MessageFileModel({
    this.id,
    this.fileName,
    this.fileUrl,
    this.coverImage,
    this.timestamp,
    this.size,
    this.duration,
  });

  factory MessageFileModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return MessageFileModel(
      id: json['id'] as String? ?? id,
      fileName: json['fileName'] as String?,
      fileUrl: json['fileUrl'] as String?,
      coverImage: json['coverImage'] as String?,
      timestamp: json['timestamp'] as Timestamp?,
      size: json['size'] as int?,
      duration: json['duration'] as int?,
    );
  }

  final String? id;
  final String? fileName;
  final String? fileUrl;
  final String? coverImage;
  final Timestamp? timestamp;
  final int? size;
  final int? duration;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'coverImage': coverImage,
      'timestamp': timestamp,
      'size': size,
      'duration': duration,
    };
  }
}
