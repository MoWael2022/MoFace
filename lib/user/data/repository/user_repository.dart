import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:moface/core/constant.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/core/websocket/websocket_constants.dart';
import 'package:moface/user/data/datasource/base_remote_user_datasource.dart';
import 'package:moface/user/domin/entites/change_profile_data_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned_web_socket.dart';
import 'package:moface/user/domin/entites/friends/friend_data.dart';
import 'package:moface/user/domin/entites/friends/friends_data_enter.dart';
import 'package:moface/user/domin/entites/friends/send_request_data_enter.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_enter.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_returned.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/domin/entites/posts/get_post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/post_data.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';
import 'package:moface/user/domin/entites/userData.dart';
import 'package:moface/user/domin/entites/user_data_for_login.dart';
import 'package:moface/user/domin/entites/user_data_for_register.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/websocket/handle_data.dart';
import '../../domin/entites/posts/post_data_enter.dart';
import '../../domin/entites/posts/user_posts.dart';
import '../../domin/entites/posts/user_view_posts.dart';
import '../model/chat/data_chat_returned_web_socket_model.dart';

class UserRepository extends BaseUserRepository {
  final BaseRemoteUserDataSource _baseRemoteUserDataSource;
  late WebSocketChannel _channel;

  UserRepository(this._baseRemoteUserDataSource);

  @override
  Future<Either<Failure, UserData>> registerRepository(
      UserDataForRegister userDataForRegister) async {
    try {
      final result = await _baseRemoteUserDataSource
          .registerRemoteDataSource(userDataForRegister);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, UserData>> loginRepository(
      UserDataForLogin userDataForLogin) async {
    try {
      final result = await _baseRemoteUserDataSource
          .loginRemoteDataSource(userDataForLogin);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, UserData>> refreshTokenRepository() async {
    try {
      final result =
          await _baseRemoteUserDataSource.refreshTokenRemoteDataSource();
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTokenValidationRepository(
      String token) async {
    try {
      final result = await _baseRemoteUserDataSource
          .ensureTokenValidationRemoteDataSource(token);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, String>> GWTRepository(String token) async {
    try {
      final result =
          await _baseRemoteUserDataSource.GWTEncryptRemoteDataSource(token);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> logoutRepository(String token) async {
    try {
      final result =
          await _baseRemoteUserDataSource.logoutRemoteDataSource(token);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, PostData>> addPostRepository(
      PostDataEnter postDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .addPostRemoteDataSource(postDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, UserPosts>> viewAllUserPostRepository(
      UserPostDataEnter userPostDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .viewUserPostIDRemoteDataSource(userPostDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, UserPosts>> viewAllUserPostForFriendsRepository(
      UserPostDataEnter userPostDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .getPostsWithFriendsIDRemoteDataSource(userPostDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, AddCommentReturnedData>> addCommentRepository(
      AddCommentDataEnter addCommentDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .addCommentRemoteDataSource(addCommentDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, AddCommentReturnedData>> deleteCommentRepository(
      AddCommentDataEnter addCommentDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .deleteCommentRemoteDataSource(addCommentDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, AddCommentReturnedData>> updateCommentRepository(
      AddCommentDataEnter addCommentDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .updateCommentRemoteDataSource(addCommentDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> addReactRepository(
      ReactDataEnter reactDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .addReactRemoteDataSource(reactDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteReactRepository(
      ReactDataEnter reactDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .deleteReactRemoteDataSource(reactDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, GetPostData>> getPostRepository(
      GetPostDataEnter getPostDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .getMyPostRemoteDataSource(getPostDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, PostData>> updatePostRepository(
      PostDataEnterForUpdate postDataEnterForUpdate) async {
    try {
      final result = await _baseRemoteUserDataSource
          .updatePostRemoteDataSource(postDataEnterForUpdate);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePostRepository(
      DataEnterDeleteForPost dataEnterForDeletePost) async {
    try {
      final result = await _baseRemoteUserDataSource
          .deletePostRemoteDataSource(dataEnterForDeletePost);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMyFriendsRepository(
      FriendsDataEnter friendsDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .getMyFriendsDataSource(friendsDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMySuggestionFriendsRepository(
      FriendsDataEnter friendsDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .getMySuggestionFriendsDataSource(friendsDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMyRequestReceiveRepository(
      FriendsDataEnter friendsDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .getMyRequestReceiveDataSource(friendsDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMyRequestSendRepository(
      FriendsDataEnter friendsDataEnter) async {
    try {
      final result = await _baseRemoteUserDataSource
          .getMyRequestsSendDataSource(friendsDataEnter);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> changeBackgroundImageRepository(
      ChangeUserImageDataEnter data) async {
    try {
      final result =
          await _baseRemoteUserDataSource.changeBackgroundImage(data);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> changeProfileImageRepository(
      ChangeUserImageDataEnter data) async {
    try {
      final result = await _baseRemoteUserDataSource.changeProfileImage(data);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> acceptRequestRepository(
      RequestDataEnter data) async {
    try {
      final result =
          await _baseRemoteUserDataSource.acceptRequestDataSource(data);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> sendRequestRepository(
      RequestDataEnter data) async {
    try {
      final result =
          await _baseRemoteUserDataSource.sendRequestDataSource(data);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelRequestRepository(
      RequestDataEnter data) async {
    try {
      final result =
          await _baseRemoteUserDataSource.cancelRequestDataSource(data);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }

  @override
  Future<void> closeConnectionRepository() async {
    _channel.sink.add('{""type": 1,"target": "OnDisconnectedAsync"}}');
    _channel.sink.close();
  }

  @override
  Stream<DataChatReturnedWebSocket> connect(userId) async* {
    _channel = WebSocketChannel.connect(Uri.parse(Constant.webSocketUrl));
    _channel.sink.add(WebSocketConstants.connect);
    _saveConnection(userId);
    await for (final message in _channel.stream) {
      yield* WebSocketHandleReturnedData.handleChatReturnedData(message);
    }
  }

  void _saveConnection(String userId) {
    _channel.sink.add(WebSocketConstants.saveConnection(userId));
  }

  @override
  Future<void> sendMessage(
      {required String receiverId, required String message}) async {
    _channel.sink.add(WebSocketConstants.sendConnection(receiverId, message));
  }

  @override
  Future<Either<Failure, List<DataChatReturned>>> getChatBetweenUsersRepo(
      DataChatEnter data) async {
    try {
      final result = await _baseRemoteUserDataSource.getChatBetweenUser(data);
      return Right(result);
    } catch (failure) {
      return Left(Failure(failure.toString().substring(
            10,
          )));
    }
  }
}
