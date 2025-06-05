import 'package:bloc_learn/models/user.dart';

class AuthSerVice {
  Future<User?> login(String email, String password) async {
    if (email == "piemahesh@gmail.com" && password == "mahesh@123") {
      return User(id: "user1", email: email, name: 'maheshwaran');
    } else if (email == "ocenmahesh@gmail.com" && password == "1234") {
      return User(id: "user2", email: email, name: 'Tharun');
    }
    return null;
  }

  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }
}
