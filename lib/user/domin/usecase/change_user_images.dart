import 'package:dartz/dartz.dart';
import 'package:moface/user/domin/entites/change_profile_data_enter.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';

import '../../../core/failure/failure.dart';
import '../repository/base_user_repository.dart';
import 'base_user_usecase.dart';

class ChangeProfileImageUseCase
    extends BaseUserUseCase<ChangeUserImageDataEnter, bool> {
  final BaseUserRepository _baseUserRepository;

  ChangeProfileImageUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(input) async {
    return await _baseUserRepository.changeProfileImageRepository(input);
  }
}

class ChangeBackgroundImageUseCase
    extends BaseUserUseCase<ChangeUserImageDataEnter, bool> {
  final BaseUserRepository _baseUserRepository;

  ChangeBackgroundImageUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(input) async {
    return await _baseUserRepository.changeBackgroundImageRepository(input);
  }
}
