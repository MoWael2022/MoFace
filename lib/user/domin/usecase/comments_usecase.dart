import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_enter.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_returned.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class AddCommentUseCase
    extends BaseUserUseCase<AddCommentDataEnter, AddCommentReturnedData> {
  final BaseUserRepository _baseUserRepository;

  AddCommentUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, AddCommentReturnedData>> call(input) async {
    return await _baseUserRepository.addCommentRepository(input);
  }
}

class DeleteCommentUseCase
    extends BaseUserUseCase<AddCommentDataEnter, AddCommentReturnedData> {
  final BaseUserRepository _baseUserRepository;

  DeleteCommentUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, AddCommentReturnedData>> call(input) async {
    return await _baseUserRepository.deleteCommentRepository(input);
  }
}

class UpdateCommentUseCase
    extends BaseUserUseCase<AddCommentDataEnter, AddCommentReturnedData> {
  final BaseUserRepository _baseUserRepository;

  UpdateCommentUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, AddCommentReturnedData>> call(input) async {
    return await _baseUserRepository.updateCommentRepository(input);
  }
}
