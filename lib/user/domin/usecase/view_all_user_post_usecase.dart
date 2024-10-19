import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/posts/post_data.dart';
import 'package:moface/user/domin/entites/posts/user_posts.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

import '../entites/posts/user_view_posts.dart';


class ViewAllUserPostUseCase extends BaseUserUseCase<UserPostDataEnter, UserPosts> {
  final BaseUserRepository _baseUserRepository;

  ViewAllUserPostUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, UserPosts>> call(input) async {
    return await _baseUserRepository.viewAllUserPostRepository(input);
  }
}
