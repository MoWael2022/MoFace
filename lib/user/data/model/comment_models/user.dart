import 'package:moface/user/domin/entites/posts/comments/add_comment_data_returned.dart';

class UserInCommentModel extends User {
  const UserInCommentModel(
      {required super.id, required super.userName, required super.profileimg});

  factory UserInCommentModel.fromJson(Map<String, dynamic> json) =>
      UserInCommentModel(
        id: json["id"],
        userName: json["userName"],
        profileimg: json["profileimg"],
      );
}
