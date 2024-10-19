import 'package:moface/user/data/model/comment_models/user.dart';
import 'package:moface/user/data/model/post_data_model.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';

import '../../domin/entites/posts/post_data.dart';

class   GetPostDataModel extends GetPostData {
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

class CommentDataForGetPostModel extends CommentDataForGetPost {
   CommentDataForGetPostModel(
      {required super.userId,
      required super.userName,
      required super.userImg,
      required super.id,
      required super.commentext,
      required super.time});

  factory CommentDataForGetPostModel.fromJson(Map<String, dynamic> json) {
    return CommentDataForGetPostModel(
        userId: json['iduser'],
        userName: json['username'],
        userImg: json['userimg'],
        id: json['idcomment'],
        commentext: json['text'],
        time: DateTime.parse(json['time']));
  }
}

class ReactModel extends React {
  const ReactModel({
    required super.id,
    required super.userName,
    required super.profileimg,
  });

  factory ReactModel.fromJson(Map<String, dynamic> json) {
    return ReactModel(
      id: json['iduser'],
      userName: json['username'],
      profileimg: json['userimg'],
    );
  }
}
