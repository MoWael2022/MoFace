import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/base_use_case/base_use_case.dart';
import 'package:mo_face_app/core/failure/failure.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_Ids.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/postsIds.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/repository/base_post_repository.dart';


class HomePostUseCase extends BaseUseCase<DataForGetPostIds, PostsIds> {
  final BasePostRepository _postRepository;

  HomePostUseCase(this._postRepository);

  @override
  Future<Either<Failure, PostsIds>> call(DataForGetPostIds input) async {
    return await _postRepository.getHomePostIdsRepository(input);
  }
}
