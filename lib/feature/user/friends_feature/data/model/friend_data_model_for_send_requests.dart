import '../../domin/entites/friend_data.dart';

class FriendDataModelForSendRequest extends FriendData {
  const FriendDataModelForSendRequest(
      {required super.username, required super.id, required super.profileImg});

  factory FriendDataModelForSendRequest.fromJson(Map<String, dynamic> json) {
    return FriendDataModelForSendRequest(
        username: json['name'],
        id: json['id'],
        profileImg: json['profileimg']);
  }
}
