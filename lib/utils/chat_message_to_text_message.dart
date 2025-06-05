import 'package:bloc_learn/models/chat_message.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

types.TextMessage chatMessageToTextMessage(ChatMessage chatMessage) {
  return types.TextMessage(
    id: chatMessage.id,
    text: chatMessage.text,
    author: types.User(id: chatMessage.senderId),
    createdAt: chatMessage.timestamp.millisecondsSinceEpoch,
  );
}
