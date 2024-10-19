import 'package:moface/user/domin/entites/friends/friend_data.dart';

class FriendDataModel extends FriendData {
  const FriendDataModel(
      {required super.username, required super.id, required super.profileImg});

  factory FriendDataModel.fromJson(Map<String, dynamic> json) {
    return FriendDataModel(
        username: json['userName'],
        id: json['id'],
        profileImg: json['profileimg']);
  }
}

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
