import 'package:equatable/equatable.dart';

class CommentDataEnter extends Equatable {

  final String? comment;
  final String userId;
  final int postId;
  final int? commentId;


  @override
  List<Object?> get props => [
        comment,
        userId,
        postId,
      ];

  const CommentDataEnter(
      {required this.comment,
      required this.userId,
      required this.postId,
      required this.commentId,});

  Map<String, String> addCommentToMap() {
    return {
      "commentext": comment!,
      "iduser": userId,
      "idpost": postId.toString(),
    };
  }
  Map<String, String> deleteCommentToMap() {
    return {
      "idcomment": commentId!.toString(),
      "iduser": userId,
      "idpost": postId.toString(),
    };
  }
  Map<String, String> updateCommentToMap() {
    return {
      "commentext": comment!,
      "iduser": userId,
      "idpost": postId.toString(),
    };
  }
}
