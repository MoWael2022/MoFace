import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_delete_post.dart';

import '../../domin/entites/data_for_add_post.dart';
import '../../domin/entites/data_for_get_post_Ids.dart';
import '../../domin/entites/data_for_get_post_data.dart';
import '../../domin/entites/data_for_update_post.dart';
import '../model/get_post_data_model.dart';
import '../model/post_data_model.dart';
import '../model/user_view_post_model.dart';

abstract class BaseRemotePostDataSource {
  Future<GetPostDataModel> getPostUsingIdRemoteDataSource(
      DataForGetPostData postData);

  Future<PostIdsModel> getHomePostsIdRemoteDataSource(
      DataForGetPostIds userPostData);

  Future<PostIdsModel> getProfilePostIdsRemoteDataSource(
      DataForGetPostIds userPostData);

  Future<PostDataModel> addPostRemoteDataSource(DataForAddPost dataForAddPost);

  Future<PostDataModel> updatePostRemoteDataSource(
      DataForUpdatePost dataForUpdatePost);

  Future<bool> deletePostRemoteDataSource(DataForDeletePost postData);
}
