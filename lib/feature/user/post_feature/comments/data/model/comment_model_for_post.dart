import '../../domin/entites/comment_data_for_post.dart';

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