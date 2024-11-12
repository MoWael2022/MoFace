import 'package:dartz/dartz.dart';

import '../../../../../../core/failure/failure.dart';
import '../entites/add_comment_data_enter.dart';
import '../entites/add_comment_data_returned.dart';

abstract class BaseCommentRepository {
  Future<Either<Failure, CommentReturnedData>> addCommentRepository(
      CommentDataEnter addCommentDataEnter);

  Future<Either<Failure, CommentReturnedData>> deleteCommentRepository(
      CommentDataEnter addCommentDataEnter);

  Future<Either<Failure, CommentReturnedData>> updateCommentRepository(
      CommentDataEnter addCommentDataEnter);
}
