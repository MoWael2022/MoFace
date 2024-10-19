import '../../../domin/entites/chat/data_chat_returned.dart';

class DataChatReturnedModel extends DataChatReturned {
  const DataChatReturnedModel(
      {required super.id,
      required super.messageText,
      required super.time,
      required super.senderId,
      required super.senderUserName,
      required super.senderUserImage,
      required super.receiverId,
      required super.receiverUserName,
      required super.receiverUserImage});

  factory DataChatReturnedModel.fromJson(Map<String, dynamic> json) {
    return DataChatReturnedModel(
      id: json['id'],
      messageText: json['messagetext'],
      time: json['time'],
      senderId: json['senderId'],
      senderUserName: json['senderUserName'],
      senderUserImage: json['senderUserimg'],
      receiverId: json['receiverId'],
      receiverUserName: json['receiverUserName'],
      receiverUserImage: json['receiverUserimg'],
    );
  }
}
