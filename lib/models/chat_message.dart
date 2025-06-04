// lib/models/chat_message.dart
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ChatMessage extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String senderId;

  @HiveField(3)
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });
  // From JSON factory
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  // To JSON method
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
