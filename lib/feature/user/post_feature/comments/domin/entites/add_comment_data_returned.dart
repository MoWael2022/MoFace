import 'package:equatable/equatable.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/entites/comment_data_for_post.dart';

import '../../../main_post/domin/entites/post_data.dart';
import '../../../main_post/domin/entites/user_data_for_post.dart';
import '../../data/model/comment_model_for_post.dart';
import 'comment_data.dart';

class CommentReturnedData extends Equatable {
  final String message;
  final Comment comment;
  final PostData post;
  final User user;

  const CommentReturnedData({
    required this.message,
    required this.comment,
    required this.post,
    required this.user,
  });

  CommentDataForGetPost convertToCommentDataForPost() {
    return CommentDataForGetPostModel(
        userId: user.id,
        userName: user.userName,
        userImg: user.profileimg,
        id: comment.id,
        commentext: comment.commentext,
        time: comment.time);
  }

  @override
  List<Object?> get props => [message, comment, post, user];
}
