import '../../../main_post/domin/entites/user_data_for_post.dart';

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
