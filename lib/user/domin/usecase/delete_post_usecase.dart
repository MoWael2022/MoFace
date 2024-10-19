import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class DeletePostUseCase extends BaseUserUseCase<DataEnterDeleteForPost, bool> {
  final BaseUserRepository _baseUserRepository;

  DeletePostUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(DataEnterDeleteForPost input) async {
    return await _baseUserRepository.deletePostRepository(input);
  }
}
