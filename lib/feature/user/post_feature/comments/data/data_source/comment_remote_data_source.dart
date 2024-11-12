import 'package:dio/dio.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/data/data_source/base_comment_remote_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/data/model/add_comment.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/entites/add_comment_data_enter.dart';

import '../../../../../../core/dio_manager/dio_client.dart';
import '../../../../../../core/dio_manager/dio_error_handlar.dart';
import '../../../../../../core/utilts/api_constant.dart';

class CommentRemoteDataSource implements BaseCommentRemoteDataSource {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<CommentModel> addCommentRemoteDataSource(
      CommentDataEnter commentDataEnter) async {
    try {
      FormData formData = FormData.fromMap(commentDataEnter.addCommentToMap());
      String path = Constant.addComment;
      final response = await _dio.post(path, data: formData);
      final data = CommentModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<CommentModel> deleteCommentRemoteDataSource(
      CommentDataEnter commentDataEnter) async {
    try {
      FormData formData = FormData.fromMap(commentDataEnter.deleteCommentToMap());
      String path = Constant.deleteComment;
      final response = await _dio.delete(path, data: formData);
      final data = CommentModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<CommentModel> updateCommentRemoteDataSource(
      CommentDataEnter commentDataEnter) async {
    try {
      FormData formData = FormData.fromMap(commentDataEnter.updateCommentToMap());
      String path = Constant.updateComment(commentDataEnter.commentId!);
      final response = await _dio.put(path, data: formData);
      final data = CommentModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
