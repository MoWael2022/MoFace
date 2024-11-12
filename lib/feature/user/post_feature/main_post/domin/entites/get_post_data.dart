import 'package:equatable/equatable.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/user_data_for_post.dart';

import '../../../reacts/domin/entites/react_entities.dart';
import '../../../comments/domin/entites/comment_data_for_post.dart';

class GetPostData extends Equatable {
  final String message;

  bool isUserReact;

  PostData post;

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

  factory GetPostData.convertFromPostData(PostData post, User userPost) {
    return GetPostData(
        message: 'message',
        post: post,
        isUserReact: false,
        userPost: userPost,
        comments: const [],
        reacts: const []);
  }

  @override
  List<Object?> get props => [
        message,
        post,
        userPost,
        comments,
        reacts,
      ];
}
