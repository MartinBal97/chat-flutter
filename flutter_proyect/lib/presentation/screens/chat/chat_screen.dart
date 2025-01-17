import 'package:flutter/material.dart';
import 'package:flutter_proyect/domain/entities/message.dart';
import 'package:flutter_proyect/presentation/providers/chat_provider.dart';
import 'package:flutter_proyect/presentation/widgets/chat/my_message_bubble.dart';
import 'package:flutter_proyect/presentation/widgets/chat/officemanager_message_bubble.dart';
import 'package:flutter_proyect/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office Manager'),
        centerTitle: false,
        leading: Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(left: 12),
            child: const CircleAvatar(
              child: Icon(Icons.person),
            )),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messageList[index];

                  return (message.fromWho == FromWho.mine)
                      ? MyMessageBubble(
                          message: message,
                        )
                      : OfficeManagerMessageBubble(
                          message: message,
                        );
                },
              ),
            ),
            MessageFieldBox(onValue: chatProvider.sendMessage)
          ],
        ),
      ),
    );
  }
}
