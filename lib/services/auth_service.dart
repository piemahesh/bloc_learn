import 'package:bloc_learn/models/user.dart';

class AuthSerVice {
  Future<User?> login(String email, String password) async {
    if (email == "piemahesh@gmail.com" && password == "mahesh@123") {
      return User(id: "1", email: email, name: 'maheshwaran');
    }
    return null;
  }

  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }
}
