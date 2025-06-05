// lib/blocs/message/message_event.dart
part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMessages extends MessageEvent {}

class SendMessage extends MessageEvent {
  final String text;
  final String senderId;

  SendMessage(this.text, this.senderId);

  @override
  List<Object> get props => [text, senderId];
}
