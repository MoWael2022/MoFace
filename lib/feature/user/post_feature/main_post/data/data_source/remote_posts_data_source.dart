import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mo_face_app/core/dio_manager/dio_error_handlar.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/data/data_source/base_remote_post_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/data/model/post_data_model.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_add_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_delete_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_update_post.dart';
import '../../../../../../core/dio_manager/dio_client.dart';
import '../../../../../../core/utilts/api_constant.dart';
import '../../domin/entites/data_for_get_post_Ids.dart';
import '../../domin/entites/data_for_get_post_data.dart';
import '../model/get_post_data_model.dart';
import '../model/user_view_post_model.dart';

class RemotePostsDataSource implements BaseRemotePostDataSource {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<GetPostDataModel> getPostUsingIdRemoteDataSource(
      DataForGetPostData postData) async {
    try {
      String path = Constant.getPost(postData.id, postData.userId);
      final response = await _dio.get(path);
      final data = GetPostDataModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<PostIdsModel> getHomePostsIdRemoteDataSource(
      DataForGetPostIds userPostData) async {
    //FormData formData = FormData.fromMap(userPostData.toMap());
    try {
      String path = Constant.viewAllUserPostFriends(userPostData.userId);
      final response = await _dio.get(path);
      print(response.data);
      final data = PostIdsModel(postsId: response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<PostIdsModel> getProfilePostIdsRemoteDataSource(
      DataForGetPostIds userPostData) async {
    try {
      String path = Constant.viewAllUserPost(userPostData.userId);
      final response = await _dio.get(path);
      final data = PostIdsModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<PostDataModel> addPostRemoteDataSource(
      DataForAddPost dataForAddPost) async {
    try {
      final headers = {
        'Content-Type':
        kIsWeb ? 'application/x-www-form-urlencoded' : 'multipart/form-data',
      };

      final mapData = await dataForAddPost.toMap();
      FormData formData = FormData.fromMap(mapData);
      const String path = Constant.addPost;
      _dio.options.headers["Content-Type"] = headers['Content-Type'];
      final response = await _dio.post(
        path,
        data: formData,
      );
      final data = PostDataModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<bool> deletePostRemoteDataSource(DataForDeletePost postData) async {
    try {
      FormData formData = FormData.fromMap(postData.toMap());
      String path = Constant.deletePost;
      await _dio.delete(
        path,
        data: formData,
      );
      print("yyyyyyyyyyyyyyyyyyyyy");
      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<PostDataModel> updatePostRemoteDataSource(
      DataForUpdatePost dataForUpdatePost) async {

    try {
      final headers = {
        'Content-Type':
        kIsWeb ? 'application/x-www-form-urlencoded' : 'multipart/form-data',
      };
      final mapData = await dataForUpdatePost.toMap();
      FormData formData = FormData.fromMap(mapData);
      String path = Constant.updatePost(dataForUpdatePost.postId);
      _dio.options.headers["Content-Type"] = headers['Content-Type'];
      final response = await _dio.patch(
        path,
        data: formData,
      );
      final data = PostDataModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
