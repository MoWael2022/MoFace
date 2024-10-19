import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/domin/entites/posts/get_post_data_enter.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

import '../entites/user_data_for_login.dart';

class GetPostDataUseCase extends BaseUserUseCase<GetPostDataEnter, GetPostData> {
  final BaseUserRepository _baseUserRepository;

  GetPostDataUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, GetPostData>> call(GetPostDataEnter input) async {
    return await _baseUserRepository.getPostRepository(input);
  }
}
