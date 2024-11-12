import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/failure/failure.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/data/data_source/base_remote_post_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_add_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_delete_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_Ids.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_update_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/get_post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/postsIds.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/repository/base_post_repository.dart';

class PostRepository implements BasePostRepository {
  final BaseRemotePostDataSource _baseRemotePostDataSource;

  PostRepository(this._baseRemotePostDataSource);

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (failure) {
      return Left(Failure(message: failure.toString()));
    }
  }

  @override
  Future<Either<Failure, PostsIds>> getHomePostIdsRepository(
      DataForGetPostIds dataForGetPostIds) async {
    return _execute(() => _baseRemotePostDataSource
        .getHomePostsIdRemoteDataSource(dataForGetPostIds));
  }

  @override
  Future<Either<Failure, PostsIds>> getProfilePostIdsRepository(
      DataForGetPostIds userPostDataEnter) async {
    return _execute(() => _baseRemotePostDataSource
        .getProfilePostIdsRemoteDataSource(userPostDataEnter));
  }

  @override
  Future<Either<Failure, GetPostData>> getPostRepository(
      DataForGetPostData dataForGetPostData) async {
    return _execute(() => _baseRemotePostDataSource
        .getPostUsingIdRemoteDataSource(dataForGetPostData));
  }

  @override
  Future<Either<Failure, PostData>> addPostRepository(DataForAddPost data) {
    return _execute(() => _baseRemotePostDataSource
        .addPostRemoteDataSource(data));
  }

  @override
  Future<Either<Failure, bool>> deletePostRepository(DataForDeletePost data) {
    return _execute(() => _baseRemotePostDataSource
        .deletePostRemoteDataSource(data));
  }

  @override
  Future<Either<Failure, PostData>> updatePostRepository(DataForUpdatePost data) {
    return _execute(() => _baseRemotePostDataSource
        .updatePostRemoteDataSource(data));
  }
}
