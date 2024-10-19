import 'package:equatable/equatable.dart';

class DataChatEnter extends Equatable {
  final String token;
  final String senderId;
  final String receiverId;

  const DataChatEnter({
    required this.token,
    required this.senderId,
    required this.receiverId,
  });

  @override
  List<Object?> get props => [
    senderId,
    receiverId,
    token,
  ];
}
