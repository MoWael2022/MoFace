import 'package:equatable/equatable.dart';

class DataChatReturned extends Equatable {
  final int id;
  final String messageText;
  final String time;
  final String senderId;
  final String senderUserName;
  final String senderUserImage;
  final String receiverId;
  final String receiverUserName;
  final String receiverUserImage;

  @override
  List<Object?> get props => [
        id,
        messageText,
        time,
        senderId,
        senderUserImage,
        senderUserImage,
        receiverId,
        receiverUserImage,
        receiverUserName,
      ];

  const DataChatReturned(
      {required this.id,
      required this.messageText,
      required this.time,
      required this.senderId,
      required this.senderUserName,
      required this.senderUserImage,
      required this.receiverId,
      required this.receiverUserName,
      required this.receiverUserImage});
}
