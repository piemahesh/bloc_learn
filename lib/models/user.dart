import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class User extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  User({required this.id, required this.email, required this.name});

  // From JSON factory
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // To JSON method
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
