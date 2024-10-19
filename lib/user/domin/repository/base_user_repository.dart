import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/data/model/chat/data_chat_returned_web_socket_model.dart';
import 'package:moface/user/domin/entites/change_profile_data_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned.dart';
import 'package:moface/user/domin/entites/friends/friend_data.dart';
import 'package:moface/user/domin/entites/friends/send_request_data_enter.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_enter.dart';
import 'package:moface/user/domin/entites/posts/comments/add_comment_data_returned.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/domin/entites/posts/get_post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/post_data.dart';
import 'package:moface/user/domin/entites/posts/post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';
import 'package:moface/user/domin/entites/userData.dart';
import 'package:moface/user/domin/entites/user_data_for_register.dart';

import '../entites/chat/data_chat_returned_web_socket.dart';
import '../entites/friends/friends_data_enter.dart';
import '../entites/user_data_for_login.dart';
import '../entites/posts/user_posts.dart';
import '../entites/posts/user_view_posts.dart';

abstract class BaseUserRepository {

  //authontication
  Future<Either<Failure ,UserData>> registerRepository(UserDataForRegister userDataForRegister);
  Future<Either<Failure ,UserData>> loginRepository(UserDataForLogin userDataForLogin);
  Future<Either<Failure ,UserData>> refreshTokenRepository();
  Future<Either<Failure ,bool>> checkTokenValidationRepository(String token);
  Future<Either<Failure ,bool>> logoutRepository(String token);
  Future<Either<Failure ,String>> GWTRepository(String token);
  //posts
  Future<Either<Failure ,PostData>> addPostRepository(PostDataEnter postDataEnter);
  Future<Either<Failure ,PostData>> updatePostRepository(PostDataEnterForUpdate postDataEnterForUpdate);
  Future<Either<Failure ,UserPosts>> viewAllUserPostRepository(UserPostDataEnter userPostDataEnter);
  Future<Either<Failure ,UserPosts>> viewAllUserPostForFriendsRepository(UserPostDataEnter userPostDataEnter);
  Future<Either<Failure ,GetPostData>> getPostRepository(GetPostDataEnter getPostDataEnter);
  Future<Either<Failure ,bool>> deletePostRepository(DataEnterDeleteForPost dataEnterForDeletePost);
  //comments
  Future<Either<Failure ,AddCommentReturnedData>> addCommentRepository(AddCommentDataEnter addCommentDataEnter);
  Future<Either<Failure ,AddCommentReturnedData>> deleteCommentRepository(AddCommentDataEnter addCommentDataEnter);
  Future<Either<Failure ,AddCommentReturnedData>> updateCommentRepository(AddCommentDataEnter addCommentDataEnter);
  //react
  Future<Either<Failure ,bool>> addReactRepository(ReactDataEnter reactDataEnter);
  Future<Either<Failure ,bool>> deleteReactRepository(ReactDataEnter reactDataEnter);
  //friends
  Future<Either<Failure ,List<FriendData>>> getMyFriendsRepository(FriendsDataEnter friendsDataEnter);
  Future<Either<Failure ,List<FriendData>>> getMySuggestionFriendsRepository(FriendsDataEnter friendsDataEnter);
  Future<Either<Failure ,List<FriendData>>> getMyRequestSendRepository(FriendsDataEnter friendsDataEnter);
  Future<Either<Failure ,List<FriendData>>> getMyRequestReceiveRepository(FriendsDataEnter friendsDataEnter);
  Future<Either<Failure ,bool>> sendRequestRepository(RequestDataEnter data);
  Future<Either<Failure ,bool>> acceptRequestRepository(RequestDataEnter data);
  Future<Either<Failure ,bool>> cancelRequestRepository(RequestDataEnter data);
  //user
  Future<Either<Failure ,bool>> changeProfileImageRepository(ChangeUserImageDataEnter data);
  Future<Either<Failure ,bool>> changeBackgroundImageRepository(ChangeUserImageDataEnter data);
  //chat
  Stream<DataChatReturnedWebSocket> connect(String userId);
  Future<void> sendMessage({required String receiverId, required String message});
  Future<void> closeConnectionRepository();
  Future<Either<Failure,List<DataChatReturned>>> getChatBetweenUsersRepo(DataChatEnter data);



}