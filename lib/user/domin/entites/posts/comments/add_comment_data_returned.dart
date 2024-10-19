import 'package:equatable/equatable.dart';

import '../post_data.dart';
import 'comment_data.dart';

class AddCommentReturnedData extends Equatable {
  final String message;
  final Comment comment;
  final PostData post;
  final User user;

  const AddCommentReturnedData({
    required this.message,
    required this.comment,
    required this.post,
    required this.user,
  });


  @override
  List<Object?> get props => [message, comment, post, user];
}


class User extends Equatable {
  final String id;
  final String userName;
  final String profileimg;

  const User({
    required this.id,
    required this.userName,
    required this.profileimg,
  });


  @override
  List<Object?> get props => [
        id,
        userName,
        profileimg,
      ];
}
