class WebSocketConstants {
  static const String connect = '{"protocol":"json","version":1}';

  static String saveConnection(userId) =>
      '{"type": 1,"target": "saveconnect","arguments": ["$userId"]}';

  static String sendConnection(userReceivedId, message) =>
      '{"type": 1,"target": "SendToUser","arguments": ["$userReceivedId","$message"]}';

  static const String closeConnection = '';
}
