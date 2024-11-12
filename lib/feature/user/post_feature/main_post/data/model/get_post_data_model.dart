import 'package:mo_face_app/feature/user/post_feature/main_post/data/model/post_data_model.dart';

import '../../../comments/data/model/comment_model_for_post.dart';
import '../../../comments/data/model/user_in_comment.dart';
import '../../../reacts/data/model/react_model_for_post.dart';
import '../../../reacts/domin/entites/react_entities.dart';
import '../../../comments/domin/entites/comment_data_for_post.dart';
import '../../domin/entites/get_post_data.dart';

class GetPostDataModel extends GetPostData {
  GetPostDataModel(
      {required super.message,
      required super.post,
      required super.isUserReact,
      required super.userPost,
      required super.comments,
      required super.reacts});

  factory GetPostDataModel.fromJson(Map<String, dynamic> json) {
    return GetPostDataModel(
      isUserReact: json['ifUSerReact'],
      message: json['message'],
      post: PostDataModel.fromJsonForCommentAndReacts(json['post']),
      userPost: UserInCommentModel.fromJson(json['user']),
      comments: (json['comments'] as List)
          .map((i) => CommentDataForGetPostModel.fromJson(i))
          .toList(),
      reacts:
          (json['reacts'] as List).map((i) => ReactModel.fromJson(i)).toList(),
    );
  }
}




