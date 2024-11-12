import 'package:mo_face_app/feature/user/post_feature/comments/data/model/user_in_comment.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/entites/add_comment_data_returned.dart';

import '../../../main_post/data/model/post_data_model.dart';

import 'comment.dart';

class CommentModel extends CommentReturnedData {
  const CommentModel(
      {required super.message,
        required super.comment,
        required super.post,
        required super.user});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      CommentModel(
        message: json["message"],
        comment: CommentDataModel.fromJson(json["comment"]),
        post: PostDataModel.fromJsonForCommentAndReacts(json["post"]),
        user: UserInCommentModel.fromJson(json["user"]),
      );
}
