import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/data/data_source/base_comment_remote_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/entites/add_comment_data_enter.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/entites/add_comment_data_returned.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/repository/base_comment_repository.dart';

import '../../../../../../core/failure/failure.dart';

class CommentRepository implements BaseCommentRepository {
  final BaseCommentRemoteDataSource _baseCommentRemoteDataSource;

  CommentRepository(this._baseCommentRemoteDataSource);

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (failure) {
      return Left( Failure(message: failure.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentReturnedData>> addCommentRepository(
      CommentDataEnter commentDataEnter) {
    return _execute(() => _baseCommentRemoteDataSource
        .addCommentRemoteDataSource(commentDataEnter));
  }

  @override
  Future<Either<Failure, CommentReturnedData>> deleteCommentRepository(
      CommentDataEnter commentDataEnter) {
    return _execute(() => _baseCommentRemoteDataSource
        .deleteCommentRemoteDataSource(commentDataEnter));
  }

  @override
  Future<Either<Failure, CommentReturnedData>> updateCommentRepository(
      CommentDataEnter commentDataEnter) {
    return _execute(() => _baseCommentRemoteDataSource
        .updateCommentRemoteDataSource(commentDataEnter));
  }
}
