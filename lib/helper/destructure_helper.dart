import 'package:bloc_learn/models/model.dart';

extension UserDestructure on User {
  (String id, String email, String name) get destructure => (id, email, name);
}
