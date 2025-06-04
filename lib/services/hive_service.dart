import 'package:bloc_learn/config/config.dart';
import 'package:bloc_learn/models/chat_message.dart';
import 'package:bloc_learn/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final _userBoxKey = "userBox";
  static final _messageBoxKey = "messageBox";
  // static const _secureKeyName = 'hive_encryption_key';
  // static final _secureStorage = const FlutterSecureStorage();
  static Future<void> init() async {
    await Hive.initFlutter();
    AppLogger.i("Hive is launched");

    // Register all adapters
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ChatMessageAdapter());
    AppLogger.i("All adapters Registered successfully");
    // Open all required boxes
    await Hive.openBox<User>(_userBoxKey);
    await Hive.openBox<ChatMessage>(_messageBoxKey);
    AppLogger.i("Hive box all are opened");
    // You can add more boxes here as needed
  }

  static Box<User> get userBox => Hive.box<User>(_userBoxKey);
  static Box<ChatMessage> get messageBox =>
      Hive.box<ChatMessage>(_messageBoxKey);
}
