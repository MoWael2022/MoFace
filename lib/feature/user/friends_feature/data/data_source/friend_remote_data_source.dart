import 'package:dio/dio.dart';
import 'package:mo_face_app/core/dio_manager/dio_client.dart';
import 'package:mo_face_app/feature/user/friends_feature/data/data_source/base_friend_remote_data_source.dart';
import 'package:mo_face_app/feature/user/friends_feature/data/model/friend_data_model.dart';
import 'package:mo_face_app/feature/user/friends_feature/data/model/friend_data_model_for_send_requests.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/entites/send_request_data_enter.dart';

import '../../../../../core/dio_manager/dio_error_handlar.dart';
import '../../../../../core/utilts/api_constant.dart';

class FriendRemoteDataSource extends BaseFriendRemoteDataSource {
  final Dio _dio = DioClient.instance.dio;

  Future<List<FriendDataModel>> _baseGetFriendsData(
      String userId, pathUrl) async {
    try {
      String path = pathUrl;
      final response = await _dio.get(path);
      print(response.data);
      final data = (response.data as List)
          .map((json) => FriendDataModel.fromJson(json))
          .toList();
      return data;
    } on DioException catch (failure) {
      throw handleDioError(failure);
    }
  }

  @override
  Future<List<FriendDataModel>> getMyFriendsDataSource(String userId) {
    return _baseGetFriendsData(userId, Constant.getMyFriends(userId));
  }

  @override
  Future<List<FriendDataModel>> getMySuggestionFriendsDataSource(
      String userId) {
    return _baseGetFriendsData(userId, Constant.getMySuggestionFriends(userId));
  }

  Future<List<FriendDataModelForSendRequest>> _baseGetFriendsDataForRequests(
      String userId, pathUrl) async {
    try {
      String path = pathUrl;
      final response = await _dio.get(path);
      final data = (response.data as List)
          .map((json) => FriendDataModelForSendRequest.fromJson(json))
          .toList();
      return data;
    } on DioException catch (failure) {
      throw handleDioError(failure);
    }
  }

  @override
  Future<List<FriendDataModelForSendRequest>> getMyRequestReceiveDataSource(
      String userId) {
    return _baseGetFriendsDataForRequests(
        userId, Constant.getMyRequestReceive(userId));
  }

  @override
  Future<List<FriendDataModelForSendRequest>> getMyRequestsSendDataSource(
      String userId) {
    return _baseGetFriendsDataForRequests(
        userId, Constant.getMyRequestSend(userId));
  }

  Future<bool> _baseManageRequestsFriends(
      pathUrl, RequestDataEnter requestData) async {
    try {
      String path = pathUrl;
      FormData formData = FormData.fromMap(requestData.toMap());
      await _dio.post(path, data: formData);
      return true;
    } on DioException catch (failure) {
      throw handleDioError(failure);
    }
  }

  @override
  Future<bool> acceptRequestDataSource(RequestDataEnter data) {
    return _baseManageRequestsFriends(Constant.acceptRequest, data);
  }

  @override
  Future<bool> sendRequestDataSource(RequestDataEnter data) {
    return _baseManageRequestsFriends(Constant.sendRequest, data);
  }

  @override
  Future<bool> cancelRequestDataSource(RequestDataEnter data) async {
    try {
      FormData formData = FormData.fromMap(data.toMap());
      String pathUrl = Constant.cancelRequest;
      await _dio.delete(pathUrl, data: formData);
      return true;
    } on DioException catch (failure) {
      throw handleDioError(failure);
    }
  }
}
