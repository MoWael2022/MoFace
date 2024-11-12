import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/base_use_case/base_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/repository/base_comment_repository.dart';

import '../../../../../../core/failure/failure.dart';
import '../entites/add_comment_data_enter.dart';
import '../entites/add_comment_data_returned.dart';

class DeleteCommentUseCase
    extends BaseUseCase<CommentDataEnter, CommentReturnedData> {
  final BaseCommentRepository _baseUserRepository;

  DeleteCommentUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, CommentReturnedData>> call(input) async {
    return await _baseUserRepository.deleteCommentRepository(input);
  }
}