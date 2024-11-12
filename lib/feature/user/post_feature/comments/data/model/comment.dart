

import '../../domin/entites/comment_data.dart';

class CommentDataModel extends Comment {
   CommentDataModel(
      {required super.id, required super.commentext, required super.time});

  factory CommentDataModel.fromJson(Map<String, dynamic> json) =>
      CommentDataModel(
        id: json["id"],
        commentext: json["commentext"],
        time: DateTime.parse(json["time"]),
      );
}
