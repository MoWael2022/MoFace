import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/base_use_case/base_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_add_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_update_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/repository/base_post_repository.dart';

import '../../../../../../core/failure/failure.dart';
import '../entites/get_post_data.dart';

class UpdatePostUseCase extends BaseUseCase<DataForUpdatePost, PostData> {
  final BasePostRepository _basePostRepository;

  UpdatePostUseCase(this._basePostRepository);

  @override
  Future<Either<Failure, PostData>> call(DataForUpdatePost input) async {
    return await _basePostRepository.updatePostRepository(input);
  }
}
