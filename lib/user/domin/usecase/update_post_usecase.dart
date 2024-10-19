import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/posts/post_data.dart';
import 'package:moface/user/domin/entites/posts/post_data_enter.dart';
import 'package:moface/user/domin/entites/userData.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';


class UpdatePostUseCase extends BaseUserUseCase<PostDataEnterForUpdate, PostData> {
  final BaseUserRepository _baseUserRepository;

  UpdatePostUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, PostData>> call(input) async {
    return await _baseUserRepository.updatePostRepository(input);
  }
}
