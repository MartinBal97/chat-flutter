import 'package:dio/dio.dart';
import 'package:flutter_proyect/domain/entities/message.dart';

class GetYesNoAnswer {
  Future<Message> getMessage() async {
    final response = await Dio().get("https://yesno.wtf/api");

    return Message(
      text: response.data['answer'],
      fromWho: FromWho.them,
      imageUrl: response.data['image'],
    );
  }
}
