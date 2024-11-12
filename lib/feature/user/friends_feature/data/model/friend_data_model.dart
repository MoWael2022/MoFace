
import '../../domin/entites/friend_data.dart';

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

