import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_add_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_delete_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_update_post.dart';

import '../../../../../../core/failure/failure.dart';
import '../entites/data_for_get_post_Ids.dart';
import '../entites/get_post_data.dart';
import '../entites/post_data.dart';
import '../entites/postsIds.dart';

abstract class BasePostRepository {
  Future<Either<Failure, PostsIds>> getHomePostIdsRepository(
      DataForGetPostIds dataForGetPostIds);

  Future<Either<Failure, PostsIds>> getProfilePostIdsRepository(
      DataForGetPostIds userPostDataEnter);

  Future<Either<Failure, GetPostData>> getPostRepository(
      DataForGetPostData dataForGetPostData);

  Future<Either<Failure, PostData>> addPostRepository(DataForAddPost data);

  Future<Either<Failure, PostData>> updatePostRepository(
      DataForUpdatePost data);

  Future<Either<Failure, bool>> deletePostRepository(DataForDeletePost data);
}
