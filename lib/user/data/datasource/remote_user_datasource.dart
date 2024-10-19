// import 'dart:html' as html;

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:moface/core/constant.dart';
import 'package:moface/user/data/datasource/base_remote_user_datasource.dart';
import 'package:moface/user/data/model/chat/data_chat_returned_model.dart';
import 'package:moface/user/data/model/comment_models/add_comment.dart';
import 'package:moface/user/data/model/friend_data_model.dart';
import 'package:moface/user/data/model/get_post_data_model.dart';
import 'package:moface/user/data/model/post_data_model.dart';
import 'package:moface/user/data/model/user_data_model.dart';
import 'package:moface/user/data/model/user_view_post_model.dart';
import 'package:moface/user/domin/entites/change_profile_data_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_enter.dart';
import 'package:moface/user/domin/entites/friends/friends_data_enter.dart';
import 'package:moface/user/domin/entites/friends/send_request_data_enter.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_enter.dart';
import 'package:moface/user/domin/entites/posts/get_post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';
import 'package:moface/user/domin/entites/user_data_for_login.dart';
import 'package:moface/user/domin/entites/user_data_for_register.dart';
import 'package:moface/user/domin/entites/posts/user_view_posts.dart';
import 'package:path_provider/path_provider.dart';
import "package:path/path.dart" as p;

import '../../../core/dio_error_handlar.dart';

class RemoteUserDataSource extends BaseRemoteUserDataSource {
  late Dio dio;
  late CookieJar cookieJar;

  RemoteUserDataSource() {
    // Initialize Dio and CookieJar
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 50), // Increase if needed
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 20),
    ));

    // Set up the PersistCookieJar to persist cookies across app restarts
    //_setupCookieManager();
  }

  // Future<void> _setupCookieManager() async {
  //   if (Platform.isAndroid) {
  //     final appDocDir = await getApplicationDocumentsDirectory();
  //     final cookieDir = p.join(appDocDir.path, "cookies");
  //     cookieJar = PersistCookieJar(storage: FileStorage(cookieDir));
  //
  //     // Attach the CookieManager to Dio
  //     dio.interceptors.add(CookieManager(cookieJar));
  //   }
  // }

  //Authentication
  @override
  Future<String> GWTEncryptRemoteDataSource(String token) async {
    const String path = Constant.decryptToken;
    FormData formData = FormData.fromMap({
      "encrypttext": token,
    });

    return await handleDioError(() async {
      final response = await dio.post(path, data: formData);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Server returned an error');
      }
    });
  }

  @override
  Future<UserDataModel> loginRemoteDataSource(
      UserDataForLogin userDataForLogin) async {
    // await _setupCookieManager();

    const String path = Constant.login;
    FormData formData = FormData.fromMap(userDataForLogin.toMap());

    return await handleDioError(() async {
      //dio.options.extra['withCredentials'] = true;
      final response = await dio.post(path, data: formData);
      if (response.statusCode == 200) {
        // final rawCookies = response.headers.map;
        // print(rawCookies);
        //final cookie = html.document.cookie;
        //print(cookie);
        //print(rawCookies);
        //html.window.document.cookie = ',m';
        final data = UserDataModel.fromJson(response.data);

        return data;
      } else {
        throw Exception('Failed to log in');
      }
    });
  }

  @override
  Future<UserDataModel> registerRemoteDataSource(
      UserDataForRegister userDataForRegister) async {
    // await _setupCookieManager();

    const String path = Constant.register;
    FormData formData = FormData.fromMap(userDataForRegister.toMap());

    return await handleDioError(() async {
      final response = await dio.post(path, data: formData);
      if (response.statusCode == 200) {
        final data = UserDataModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Server returned an error');
      }
    });
  }

  @override
  Future<UserDataModel> refreshTokenRemoteDataSource() async {
    // await _setupCookieManager();

    const String path = Constant.refreshToken;

    return await handleDioError(() async {
      final response = await dio.get(path);
      if (response.statusCode == 200) {
        final data = UserDataModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to refresh token');
      }
    });
  }

  @override
  Future<bool> ensureTokenValidationRemoteDataSource(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    const String path = Constant.ensureTokenValidation;

    return await handleDioError(() async {
      final response = await dio.get(path,
          options: Options(
            headers: headers,
          ));
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        throw Exception('Failed to check token');
      }
    });
  }

  @override
  Future<bool> logoutRemoteDataSource(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await handleDioError(() async {
      dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
      const String path = Constant.logout;
      final response = await dio.post(path,
          options: Options(
            headers: headers,
          ));
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  // Manage Posts
  @override
  Future<UserViewPostModel> getPostsWithFriendsIDRemoteDataSource(UserPostDataEnter userPostData) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userPostData.token}',
    };
    //FormData formData = FormData.fromMap(userPostData.toMap());
    return await handleDioError(() async {
      String path = Constant.viewAllUserPostFriends(userPostData.userId);
      final response = await dio.get(path,
          options: Options(
            headers: headers,
          ));
      print(response.data);
      if (response.statusCode == 200) {
        //final data = UserViewPostModel.fromJson(response.data);
        final data = UserViewPostModel(postsId: response.data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }


  @override
  Future<PostDataModel> addPostRemoteDataSource(
      PostDataEnter postDataEnter) async {
    final headers = {
      'Content-Type':
          kIsWeb ? 'application/x-www-form-urlencoded' : 'multipart/form-data',
      'Authorization': 'Bearer ${postDataEnter.token}',
    };

    final mapData = await postDataEnter.toMap();
    FormData formData = FormData.fromMap(mapData);

    return await handleDioError(() async {
      dio.options.headers["Content-Type"] = headers['Content-Type'];
      const String path = Constant.addPost;

      final response = await dio.post(path,
          data: formData,
          options: Options(
            headers: headers,
          ));

      print(response.data);
      if (response.statusCode == 200) {
        final data = PostDataModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to add post');
      }
    });
  }

  @override
  Future<UserViewPostModel> viewUserPostIDRemoteDataSource(
      UserPostDataEnter userPostData) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userPostData.token}',
    };
    FormData formData = FormData.fromMap(userPostData.toMap());
    return await handleDioError(() async {
      String path = Constant.viewAllUserPost(userPostData.userId);
      final response = await dio.get(path,
          options: Options(
            headers: headers,
          ));
      print(response.data);
      if (response.statusCode == 200) {
        final data = UserViewPostModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<GetPostDataModel> getMyPostRemoteDataSource(
      GetPostDataEnter postData) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${postData.token}',
    };
    return await handleDioError(() async {
      String path = Constant.getPost(postData.id, postData.userId);
      final response = await dio.get(path,
          options: Options(
            headers: headers,
          ));
      if (response.statusCode == 200) {
        final data = GetPostDataModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<PostDataModel> updatePostRemoteDataSource(
      PostDataEnterForUpdate postDataEnterForUpdate) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${postDataEnterForUpdate.token}',
    };
    final mapData = await postDataEnterForUpdate.toMap();
    FormData formData = FormData.fromMap(mapData);
    return await handleDioError(() async {
      dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
      String path = Constant.updatePost(postDataEnterForUpdate.postId);
      final response = await dio.patch(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      //print(response.data);
      if (response.statusCode == 200) {
        final data = PostDataModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<bool> deletePostRemoteDataSource(
      DataEnterDeleteForPost postData) async {
    final headers = {
      'Authorization': 'Bearer ${postData.token}',
    };
    FormData formData = FormData.fromMap(postData.convertToMap());
    //print(formData.fields);
    return await handleDioError(() async {
      String path = Constant.deletePost;
      final response = await dio.delete(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      //print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed Delete Post ');
      }
    });
  }

  //manage Comments
  @override
  Future<AddCommentModel> addCommentRemoteDataSource(
      AddCommentDataEnter addCommentDataEnter) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${addCommentDataEnter.token}',
    };
    FormData formData = FormData.fromMap(addCommentDataEnter.addCommentToMap());
    return await handleDioError(() async {
      String path = Constant.addComment;
      final response = await dio.post(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      //print(response.data);
      if (response.statusCode == 200) {
        final data = AddCommentModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<AddCommentModel> deleteCommentRemoteDataSource(
      AddCommentDataEnter addCommentDataEnter) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${addCommentDataEnter.token}',
    };
    FormData formData =
        FormData.fromMap(addCommentDataEnter.deleteCommentToMap());
    return await handleDioError(() async {
      String path = Constant.deleteComment;
      final response = await dio.delete(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      // print(response.data);
      if (response.statusCode == 200) {
        final data = AddCommentModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<AddCommentModel> updateCommentRemoteDataSource(
      AddCommentDataEnter addCommentDataEnter) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${addCommentDataEnter.token}',
    };
    FormData formData =
        FormData.fromMap(addCommentDataEnter.updateCommentToMap());
    return await handleDioError(() async {
      String path = Constant.updateComment(addCommentDataEnter.commentId!);
      final response = await dio.put(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      //print(response.data);
      if (response.statusCode == 200) {
        final data = AddCommentModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  //Manage Reacts
  @override
  Future<bool> addReactRemoteDataSource(ReactDataEnter reactDataEnter) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${reactDataEnter.token}',
    };
    FormData formData = FormData.fromMap(reactDataEnter.toMap());
    return await handleDioError(() async {
      String path = Constant.react;
      final response = await dio.post(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      //print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<bool> deleteReactRemoteDataSource(
      ReactDataEnter reactDataEnter) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${reactDataEnter.token}',
    };
    FormData formData = FormData.fromMap(reactDataEnter.toMap());
    return await handleDioError(() async {
      String path = Constant.react;
      final response = await dio.delete(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      // print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  //Manage Friends
  Future<List<FriendDataModel>> baseGetFriendsData(
      FriendsDataEnter data, pathUrl) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data.token}',
    };
    return await handleDioError(() async {
      String path = pathUrl;
      final response = await dio.get(path,
          options: Options(
            headers: headers,
          ));
      if (response.statusCode == 200) {
        final data = (response.data as List)
            .map((json) => FriendDataModel.fromJson(json))
            .toList();
        //print(data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  Future<List<FriendDataModelForSendRequest>> baseGetFriendsDataForRequests(
      FriendsDataEnter data, pathUrl) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data.token}',
    };
    return await handleDioError(() async {
      String path = pathUrl;
      final response = await dio.get(path,
          options: Options(
            headers: headers,
          ));
      if (response.statusCode == 200) {
        final data = (response.data as List)
            .map((json) => FriendDataModelForSendRequest.fromJson(json))
            .toList();
        //print(data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<List<FriendDataModel>> getMyFriendsDataSource(
      FriendsDataEnter data) async {
    return baseGetFriendsData(data, Constant.getMyFriends(data.userId));
  }

  @override
  Future<List<FriendDataModel>> getMySuggestionFriendsDataSource(
      FriendsDataEnter data) async {
    return baseGetFriendsData(
        data, Constant.getMySuggestionFriends(data.userId));
  }

  @override
  Future<List<FriendDataModelForSendRequest>> getMyRequestReceiveDataSource(
      FriendsDataEnter data) {
    return baseGetFriendsDataForRequests(data, Constant.getMyRequestReceive(data.userId));
  }

  @override
  Future<List<FriendDataModelForSendRequest>> getMyRequestsSendDataSource(
      FriendsDataEnter data) {
    return baseGetFriendsDataForRequests(data, Constant.getMyRequestSend(data.userId));
  }

  //user
  Future<bool> _baseChangeImage(ChangeUserImageDataEnter data, pathUrl) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data.token}',
    };
    final mapData = await data.toMap();
    FormData formData = FormData.fromMap(mapData);
    print(formData.fields);
    return await handleDioError(() async {
      String path = pathUrl;
      final response = await dio.post(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<bool> changeBackgroundImage(ChangeUserImageDataEnter data) {
    return _baseChangeImage(
      data,
      Constant.changeBackgroundImage(data.userId),
    );
  }

  @override
  Future<bool> changeProfileImage(ChangeUserImageDataEnter data) {
    return _baseChangeImage(
      data,
      Constant.changeProfileImage(data.userId),
    );
  }

  Future<bool> _baseManageRequestsFriends(
      path, RequestDataEnter data) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data.token}',
    };
    FormData formData = FormData.fromMap(data.toMap());
    return await handleDioError(() async {
      String pathUrl = path;
      final response = await dio.post(path,
          data: formData,
          options: Options(
            headers: headers,
          ));
      //print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed logout');
      }
    });
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
  Future<bool> cancelRequestDataSource(RequestDataEnter data) async{
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data.token}',
    };
    FormData formData = FormData.fromMap(data.toMap());
    return await handleDioError(() async {
      String pathUrl = Constant.cancelRequest;
      final response = await dio.delete(pathUrl,
          data: formData,
          options: Options(
            headers: headers,
          ));
      //print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed logout');
      }
    });
  }

  @override
  Future<List<DataChatReturnedModel>> getChatBetweenUser(DataChatEnter data) async{
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${data.token}',
    };
    return await handleDioError(() async {
      String path = Constant.getChatBetweenUser(data.senderId, data.receiverId);
      final response = await dio.get(path,
          options: Options(
            headers: headers,
          ));
      if (response.statusCode == 200) {
        final data = (response.data as List)
            .map((json) => DataChatReturnedModel.fromJson(json))
            .toList();
        //print(data);
        return data;
      } else {
        throw Exception('Failed logout');
      }
    });

  }




}
