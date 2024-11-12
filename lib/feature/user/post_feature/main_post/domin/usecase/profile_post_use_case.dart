import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/base_use_case/base_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_Ids.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/postsIds.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/repository/base_post_repository.dart';

import '../../../../../../core/failure/failure.dart';

class GetProfilePostUseCase extends BaseUseCase<DataForGetPostIds, PostsIds> {
  final BasePostRepository _basePostRepository;

  GetProfilePostUseCase(this._basePostRepository);

  @override
  Future<Either<Failure, PostsIds>> call(input) async =>
      await _basePostRepository.getProfilePostIdsRepository(input);
}
