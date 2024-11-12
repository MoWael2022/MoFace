import 'package:mo_face_app/feature/user/post_feature/comments/data/model/comment.dart';

import '../../domin/entites/add_comment_data_returned.dart';

abstract class CommentState {}

class InitState extends CommentState {}

class CommentLoadingState extends CommentState {}

class AddCommentLoadedState extends CommentState {
  CommentReturnedData commentData;

  AddCommentLoadedState(this.commentData);
}

class DeleteCommentLoadedState extends CommentState {
  CommentReturnedData commentData;

  DeleteCommentLoadedState(this.commentData);
}

class UpdateCommentLoadedState extends CommentState {
  CommentReturnedData commentData;

  UpdateCommentLoadedState(this.commentData);
}

class CommentErrorState extends CommentState {
  String messageError;

  CommentErrorState(this.messageError);
}
