import 'package:flutter/material.dart';
import 'package:flutter_proyect/config/helpers/get_yes_no_answer.dart';
import 'package:flutter_proyect/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [];

  Future<void> themMessage() async {
    final themMessage = await getYesNoAnswer.getMessage();
    messageList.add(themMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final myMessage = Message(text: text, fromWho: FromWho.mine);
    messageList.add(myMessage);

    if (text.endsWith("?")) {
      themMessage();
    }

    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCubic,
    );
  }
}
