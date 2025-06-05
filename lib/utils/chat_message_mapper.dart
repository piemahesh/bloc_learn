// lib/utils/chat_message_mapper.dart
import 'package:bloc_learn/models/chat_message.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class ChatMessageMapper {
  static List<CustomMessage> toChatTypes(List<ChatMessage> messages) {
    return messages
        .map(
          (msg) => CustomMessage(
            id: msg.id,
            authorId: msg.senderId,
            createdAt: msg.timestamp,
            metadata: {"text": msg.text},
          ),
        )
        .toList();
  }
}
