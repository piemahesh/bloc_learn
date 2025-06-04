// lib/blocs/message/message_state.dart
part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessagesLoaded extends MessageState {
  final List<ChatMessage> messages;

  MessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}
