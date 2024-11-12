import '../../domin/entites/add_comment_data_enter.dart';
import '../model/add_comment.dart';

abstract class BaseCommentRemoteDataSource {
  Future<CommentModel> addCommentRemoteDataSource(
      CommentDataEnter commentDataEnter);

  Future<CommentModel> deleteCommentRemoteDataSource(
      CommentDataEnter commentDataEnter);

  Future<CommentModel> updateCommentRemoteDataSource(
      CommentDataEnter commentDataEnter);
}
