import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/posts/user_posts.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

import '../entites/posts/user_view_posts.dart';

class GetPostWithMyFriendsUseCase
    extends BaseUserUseCase<UserPostDataEnter, UserPosts> {
  final BaseUserRepository _baseUserRepository;

  GetPostWithMyFriendsUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, UserPosts>> call(UserPostDataEnter input) async {
    return await _baseUserRepository.viewAllUserPostForFriendsRepository(input);
  }
}
