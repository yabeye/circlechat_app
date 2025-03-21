class ChatModel {
  ChatModel({
    required this.id,
    this.chatName,
    this.lastMessage,
    this.messageTime,
    this.isPinned,
    this.isSeen,
    this.isGroup,
    this.lastMessageUserId,
  });

  final String id;
  final String? chatName;
  final String? lastMessage;
  final String? messageTime;
  final bool? isPinned;
  final bool? isSeen;
  final bool? isGroup;
  final String? lastMessageUserId;

  ChatModel copyWith({
    String? id,
    String? chatName,
    String? lastMessage,
    String? messageTime,
    bool? isPinned,
    bool? isSelected,
    bool? isSeen,
    bool? isGroup,
    String? lastMessageUserId,
  }) {
    return ChatModel(
      id: id ?? this.id,
      chatName: chatName ?? this.chatName,
      lastMessage: lastMessage ?? this.lastMessage,
      messageTime: messageTime ?? this.messageTime,
      isPinned: isPinned ?? this.isPinned,
      isSeen: isSeen ?? this.isSeen,
      isGroup: isGroup ?? this.isGroup,
      lastMessageUserId: lastMessageUserId ?? this.lastMessageUserId,
    );
  }
}
