import 'dart:math';

import 'package:bloc_learn/config/app_logger.dart';
import 'package:bloc_learn/message_bloc/message_bloc.dart';
import 'package:bloc_learn/screens/custom_text_message_widget.dart';
import 'package:bloc_learn/utils/chat_message_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatController _chatController;

  static const String _currentUserId = 'user1';

  @override
  void initState() {
    super.initState();
    // _initMockMessages();
    _chatController = InMemoryChatController();
    _loadMessages();
  }

  // void _initMockMessages() {
  //   // context.read<MessageBloc>().add(LoadMockMessage());
  // }

  void _loadMessages() {
    context.read<MessageBloc>().add(LoadMessages());
  }

  void _onSendPressed(TextMessage message) {
    context.read<MessageBloc>().add(SendMessage(message.text, _currentUserId));
  }

  Widget _buildCustomMessage(types.TextMessage message, {required User user}) {
    if (message is TextMessage) {
      return CustomTextMessageWidget(
        message: message,
        isMe: message.author.id == _currentUserId,
      );
    }
    return const SizedBox.shrink(); // fallback for unsupported types
  }

  void _handleSend(types.PartialText message) {
    context.read<MessageBloc>().add(SendMessage(message.text, _currentUserId));
    AppLogger.i("message  $message");
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is MessagesLoaded) {
              state.messages.forEach((mes) {
                _chatController.insertMessage(
                  TextMessage(
                    // Better to use UUID or similar for the ID - IDs must be unique
                    id: mes.id,
                    authorId: mes.senderId,
                    createdAt: DateTime.now().toUtc(),
                    text: mes.text,
                  ),
                );
              });
            }
            return Chat(
              chatController: _chatController,
              resolveUser: (UserID id) async {
                return User(id: id, name: 'John Doe');
              },
              currentUserId: _currentUserId,
              onMessageSend: (text) {
                TextMessage message = TextMessage(
                  id: Uuid().v4(),
                  authorId: _currentUserId,
                  text: text,
                );
                // _chatController.insertMessage(message);
                _onSendPressed(message);
              },
            );
          },
        ),
      ),
    );
  }
}
