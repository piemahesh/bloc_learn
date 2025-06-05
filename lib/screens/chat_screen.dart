import 'package:bloc_learn/blocs/auth_bloc.dart';
import 'package:bloc_learn/blocs/auth_state.dart';
import 'package:bloc_learn/config/app_logger.dart';
import 'package:bloc_learn/message_bloc/message_bloc.dart';
import 'package:bloc_learn/models/chat_message.dart';
import 'package:bloc_learn/screens/custom_text_message_widget.dart';
import 'package:bloc_learn/utils/chat_message_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chats_ui;
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(5),
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 35,
        title: Text("Chats", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          Icon(Icons.notification_important_outlined, color: Colors.white),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return _Chats(
                user: User(name: state.user.name, id: state.user.id),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                context.go("/home");
              },
              child: Text("Go to home"),
            ),
          ],
        ),
      ),
    );
  }
}

// chat widget

class _Chats extends StatefulWidget {
  final User user;

  const _Chats({super.key, required this.user});

  @override
  State<_Chats> createState() => _ChatsState();
}

class _ChatsState extends State<_Chats> {
  final InMemoryChatController _chatController = InMemoryChatController();
  final Set<String> _insertedMessageIds = {};

  @override
  void initState() {
    super.initState();
    // Initial load event if needed
    context.read<MessageBloc>().add(LoadMessages());
  }

  void _onMessageSend(String text) {
    context.read<MessageBloc>().add(SendMessage(text, widget.user.id));
  }

  void _handleIncomingMessages(List<ChatMessage> msg) {
    final messages = ChatMessageMapper.toChatTypes(msg);
    AppLogger.wtf("listening ............................");
    for (final msg in messages) {
      if (!_insertedMessageIds.contains(msg.id)) {
        _chatController.insertMessage(
          CustomMessage(
            id: msg.id,
            authorId: msg.authorId,
            metadata: msg.metadata,
          ),
        );
        _insertedMessageIds.add(msg.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      buildWhen: (_, _) => true,
      builder: (context, state) {
        AppLogger.i("Bloc Builder is building ......");
        // Initial build, maybe show loading indicator
        if (state is MessageInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MessagesLoaded) {
          _handleIncomingMessages(state.messages);
        }

        return chats_ui.Chat(
          chatController: _chatController,
          currentUserId: widget.user.id,
          resolveUser: (id) async => User(id: id),
          onMessageSend: _onMessageSend,
          backgroundColor: Colors.white10,
          userCache: UserCache(maxSize: 100),
          builders: Builders(
            customMessageBuilder: (context, message, messageWidth) {
              // AppLogger.wtf(message.toJson());
              return CustomTextMessageWidget(
                message: message,
                isMe: widget.user.id == message.authorId,
              );
            },
          ),
        );
      },
    );
  }
}
