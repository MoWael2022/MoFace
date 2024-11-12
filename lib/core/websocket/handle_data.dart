// import 'dart:convert';
//
// import '../../user/auth/data/model/chat/data_chat_returned_web_socket_model.dart';
// import '../../user/auth/domin/entites/chat/data_chat_returned_web_socket.dart';
//
// class WebSocketHandleReturnedData {
//   static Stream<DataChatReturnedWebSocket> handleChatReturnedData(
//       String message) async* {
//     print(message);
//     final cleanedMessage = message.replaceAll('', '').trim();
//     final parsedMessage = jsonDecode(cleanedMessage);
//     if (parsedMessage['type'] == 1) {
//       yield DataChatReturnedWebSocketModel.fromText(parsedMessage);
//     } else if (parsedMessage['type'] == 7) {}
//   }
// }
