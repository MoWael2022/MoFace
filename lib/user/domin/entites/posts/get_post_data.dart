import 'package:equatable/equatable.dart';
import 'package:moface/user/domin/entites/posts/post_data.dart';
import 'comments/add_comment_data_returned.dart';
import 'comments/comment_data.dart';

class GetPostData extends Equatable {
  final String message;

  bool isUserReact;

  final PostData post;

  final User userPost;

  final List<CommentDataForGetPost> comments;

  final List<React> reacts;

   GetPostData(
      {required this.message,
      required this.post,
      required this.isUserReact,
      required this.userPost,
      required this.comments,
      required this.reacts});

  @override
  List<Object?> get props => [
        message,
        post,
        userPost,
        comments,
        reacts,
      ];
}

class CommentDataForGetPost extends Comment {
  final String userId;

  final String userName;
  final String userImg;

   CommentDataForGetPost(
      {required this.userId,
      required this.userName,
      required this.userImg,
      required super.id,
      required super.commentext,
      required super.time});
}

class React extends User {
  const React({
    required super.id,
    required super.userName,
    required super.profileimg,
  });
}
