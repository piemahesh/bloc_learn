// lib/utils/chat_message_mapper.dart
import 'package:bloc_learn/models/chat_message.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessageMapper {
  static List<types.Message> toChatTypes(List<ChatMessage> messages) {
    return messages
        .map(
          (msg) => types.TextMessage(
            id: msg.id,
            author: types.User(id: msg.senderId),
            createdAt: msg.timestamp.millisecondsSinceEpoch,
            text: msg.text,
          ),
        )
        .toList()
        .reversed
        .toList();
  }
}
