import 'dart:convert';

import 'package:moface/user/domin/entites/chat/data_chat_returned_web_socket.dart';

class DataChatReturnedWebSocketModel extends DataChatReturnedWebSocket {
  const DataChatReturnedWebSocketModel({
    required super.type,
    required super.target,
    required super.arguments,
  });

  factory DataChatReturnedWebSocketModel.fromText(Map<String ,dynamic> message) {

    return DataChatReturnedWebSocketModel(
      type: message['type'],
      target: message['target'],
      arguments: message['arguments'],
    );
  }
}
