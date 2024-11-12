import 'comment_data.dart';

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
