import 'package:bloc_learn/config/app_logger.dart';
import 'package:bloc_learn/models/chat_message.dart';
import 'package:bloc_learn/repositories/message_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _repository;

  MessageBloc(this._repository) : super(MessageInitial()) {
    on<LoadMessages>((event, emit) {
      final messages = _repository.getMessages();
      emit(MessagesLoaded(messages));
    });

    on<SendMessage>((event, emit) async {
      await _repository.addMessage(event.text, event.senderId);
      final messages = _repository.getMessages();
      emit(MessagesLoaded(messages));
    });
    //   load mock data
    on<LoadMockMessage>((event, emit) async {
      await _repository.loadMockMessages();
      AppLogger.d("mock message loaded successfully");
    });
  }
}
