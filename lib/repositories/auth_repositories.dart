import 'package:bloc_learn/config/config.dart';
import 'package:bloc_learn/models/user.dart';
import 'package:bloc_learn/services/service.dart';
import 'package:hive/hive.dart';

class AuthRepository {
  final AuthSerVice _authSerVice = AuthSerVice();
  final Box<User> _userBox = HiveService.userBox;
  final boxKey = "currentUser";

  Future<User?> login(String email, String password) async {
    try {
      final user = await _authSerVice.login(email, password);
      if (user != null) {
        await _userBox.put(boxKey, user);
        if (!_userBox.containsKey(boxKey)) {
          await _userBox.put(boxKey, user);
        } else {
          AppLogger.w('User exists: ${_userBox.get(boxKey)?.name}');
        }
        return user;
      }
      return null;
    } catch (e) {
      AppLogger.e("Login error ", e);
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _authSerVice.logout();
      await _userBox.delete(boxKey);
    } catch (e) {
      AppLogger.e("logout issue", e);
    }
  }

  User? getCurrentUser() => _userBox.get(boxKey);
  bool isAuthenticated() => _userBox.containsKey(boxKey);
}
