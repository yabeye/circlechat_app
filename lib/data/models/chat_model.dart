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
    this.isVerified,
  });

  final String id;
  final String? chatName;
  final String? lastMessage;
  final String? messageTime;
  final bool? isPinned;
  final bool? isSeen;
  final bool? isGroup;
  final String? lastMessageUserId;
  // Temporary field to indicate account verification status
  final bool? isVerified;

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
    bool? isVerified,
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
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
