import 'package:equatable/equatable.dart';

class AddCommentDataEnter extends Equatable {

  final String? comment;
  final String userId;
  final int postId;
  final int? commentId;

  final String token;

  @override
  List<Object?> get props => [
        comment,
        userId,
        postId,
        token,
      ];

  const AddCommentDataEnter(
      {required this.comment,
      required this.userId,
      required this.postId,
      required this.commentId,
      required this.token});

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
