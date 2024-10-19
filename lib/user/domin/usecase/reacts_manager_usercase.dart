import 'package:dartz/dartz.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';

import '../../../core/failure/failure.dart';
import '../repository/base_user_repository.dart';
import 'base_user_usecase.dart';

class AddReactUseCase
    extends BaseUserUseCase<ReactDataEnter, bool> {
  final BaseUserRepository _baseUserRepository;

  AddReactUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(input) async {
    return await _baseUserRepository.addReactRepository(input);
  }
}


class DeleteReactUseCase
    extends BaseUserUseCase<ReactDataEnter, bool> {
  final BaseUserRepository _baseUserRepository;

  DeleteReactUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(input) async {
    return await _baseUserRepository.deleteReactRepository(input);
  }
}