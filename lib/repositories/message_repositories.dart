import 'package:bloc_learn/models/chat_message.dart';
import 'package:bloc_learn/services/hive_service.dart';
import 'package:uuid/uuid.dart';

class MessageRepository {
  final _box = HiveService.messageBox;

  Future<void> addMessage(String text, String senderId) async {
    final newMessage = ChatMessage(
      id: const Uuid().v4(),
      text: text,
      senderId: senderId,
      timestamp: DateTime.now(),
    );
    await _box.add(newMessage);
  }

  List<ChatMessage> getMessages() {
    return _box.values.toList();
  }

  Future<void> loadMockMessages() async {
    if (_box.isNotEmpty) return;

    final now = DateTime.now();
    for (int i = 0; i < 20; i++) {
      final sender = i % 2 == 0 ? 'user1' : 'user2';
      await _box.add(
        ChatMessage(
          id: const Uuid().v4(),
          text: 'Mock message $i from $sender',
          senderId: sender,
          timestamp: now.subtract(Duration(minutes: i * 2)),
        ),
      );
    }
  }
}
