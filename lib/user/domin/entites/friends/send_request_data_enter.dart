import 'package:equatable/equatable.dart';

class RequestDataEnter extends Equatable {
  final String userId;
  final String friendId;
  final String token;

  const RequestDataEnter(
      {required this.token, required this.userId, required this.friendId});

  Map<String, String> toMap() {
    return {
      "userid": userId,
      "friedid": friendId,
    };
  }

  @override
  List<Object?> get props =>
      [
        userId,
        friendId,
        token,
      ];
}
