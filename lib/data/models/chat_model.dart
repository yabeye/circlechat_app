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
    this.status,
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
      status: json['status'] != null
          ? MessageStatusModel.fromJson(json['status'] as Map<String, dynamic>)
          : null,
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
  final MessageStatusModel? status;

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
      'status': status?.toJson(),
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
    this.status,
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
      status: MessageStatus.values.byName(json['status']),
    );
  }

  String? id;
  final String? senderId;
  final String? text;
  final Timestamp? timestamp;
  final MessageType? type;
  final MessageFileModel? file;
  MessageStatus? status;

  Map<String, dynamic> toJson({bool nowTimestamp = false}) {
    final timestamp =
        nowTimestamp ? Timestamp.now() : this.timestamp ?? Timestamp.now();
    return {
      // 'id': id,
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
      'type': type?.name,
      'file': file,
      'status': status?.name,
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

// create a message status model //
/**
 * {
 *    "summary": enum MessageStatus , 
 *    "delivered": {
 *     "id": {"userId":"abc123" , timestamp: Timestamp},
 *     "id": {"userId":"abc123" , timestamp: Timestamp},
 *     "id": {"userId":"abc123" , timestamp: Timestamp},
 *   
 *     }, 
 * *   "seen": {
 *     "id": {"userId":"abc123" , timestamp: Timestamp},
 *     "id": {"userId":"abc123" , timestamp: Timestamp},
 *     "id": {"userId":"abc123" , timestamp: Timestamp},
 *     }, 
 * }
 * 
 */
class MessageStatusModel {
  MessageStatusModel({
    this.summary,
    this.delivered = const {},
    this.seen = const {},
  });

  factory MessageStatusModel.fromJson(Map<String, dynamic> json) {
    return MessageStatusModel(
      summary: json['summary'] != null
          ? MessageStatus.values.byName(json['summary'])
          : null,
      delivered: (json['delivered'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              MessageStatusEntry.fromJson(value as Map<String, dynamic>),
            ),
          ) ??
          {},
      // seen: (json['seen'] as Map<String, dynamic>?)?.map(
      //       (key, value) => MapEntry(
      //         key,
      //         MessageStatusEntry.fromJson(value as Map<String, dynamic>),
      //       ),
      //     ) ??
      //     {},
    );
  }

  MessageStatus? summary;
  final Map<String, MessageStatusEntry> delivered;
  final Map<String, MessageStatusEntry> seen;

  Map<String, dynamic> toJson() {
    return {
      'summary': summary?.name,
      'delivered': delivered.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'seen': seen.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }
}

class MessageStatusEntry {
  MessageStatusEntry({
    this.timestamp,
  });

  factory MessageStatusEntry.fromJson(Map<String, dynamic> json) {
    return MessageStatusEntry(
      timestamp: json['timestamp'] as Timestamp?,
    );
  }

  final Timestamp? timestamp;

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
    };
  }
}
