import 'package:moface/user/data/model/comment_models/comment.dart';
import 'package:moface/user/data/model/comment_models/user.dart';
import 'package:moface/user/data/model/post_data_model.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_returned.dart';

class AddCommentModel extends AddCommentReturnedData {
  const AddCommentModel(
      {required super.message,
      required super.comment,
      required super.post,
      required super.user});

  factory AddCommentModel.fromJson(Map<String, dynamic> json) =>
      AddCommentModel(
        message: json["message"],
        comment: CommentDataModel.fromJson(json["comment"]),
        post: PostDataModel.fromJsonForCommentAndReacts(json["post"]),
        user: UserInCommentModel.fromJson(json["user"]),
      );
}
