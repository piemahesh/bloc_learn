import 'package:bloc_learn/config/config.dart';
import 'package:bloc_learn/models/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final userBoxKey = "userBox";
  static Future<void> init() async {
    await Hive.initFlutter();
    AppLogger.i("Hive is launched");

    // Register all adapters
    Hive.registerAdapter(UserAdapter());
    AppLogger.i("All adapters Registered successfully");
    // Open all required boxes
    await Hive.openBox<User>(userBoxKey);
    AppLogger.i("Hive box all are opened");
    // You can add more boxes here as needed
  }

  static Box<User> get userBox => Hive.box<User>(userBoxKey);
}
