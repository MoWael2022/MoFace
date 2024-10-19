import 'package:moface/user/data/model/chat/data_chat_returned_model.dart';
import 'package:moface/user/data/model/friend_data_model.dart';
import 'package:moface/user/data/model/get_post_data_model.dart';
import 'package:moface/user/domin/entites/change_profile_data_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_enter.dart';
import 'package:moface/user/domin/entites/friends/friends_data_enter.dart';
import 'package:moface/user/domin/entites/friends/send_request_data_enter.dart';
import 'package:moface/user/domin/entites/posts/get_post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/post_data_enter.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';
import 'package:moface/user/domin/entites/user_data_for_login.dart';
import '../../domin/entites/posts/comments/add_comment_data_enter.dart';
import '../../domin/entites/user_data_for_register.dart';
import '../../domin/entites/posts/user_view_posts.dart';
import '../model/comment_models/add_comment.dart';
import '../model/post_data_model.dart';
import '../model/user_data_model.dart';
import '../model/user_view_post_model.dart';

abstract class BaseRemoteUserDataSource {

//authontication
Future<UserDataModel> loginRemoteDataSource(UserDataForLogin userDataForLogin);
Future<UserDataModel> registerRemoteDataSource(UserDataForRegister userDataForRegister);
Future<UserDataModel> refreshTokenRemoteDataSource();
Future<bool> ensureTokenValidationRemoteDataSource(String token);
Future<bool> logoutRemoteDataSource(String token);
Future<String> GWTEncryptRemoteDataSource(String token);
//post
Future<PostDataModel> addPostRemoteDataSource(PostDataEnter postDataEnter);
Future<PostDataModel> updatePostRemoteDataSource(PostDataEnterForUpdate postDataEnterForUpdate);
Future<UserViewPostModel> viewUserPostIDRemoteDataSource(UserPostDataEnter userPostData);
Future<UserViewPostModel> getPostsWithFriendsIDRemoteDataSource(UserPostDataEnter userPostData);
Future<GetPostDataModel> getMyPostRemoteDataSource(GetPostDataEnter postData);

Future<bool> deletePostRemoteDataSource(DataEnterDeleteForPost postData);
//comment
Future<AddCommentModel> addCommentRemoteDataSource(AddCommentDataEnter addCommentDataEnter);
Future<AddCommentModel> deleteCommentRemoteDataSource(AddCommentDataEnter addCommentDataEnter);
Future<AddCommentModel> updateCommentRemoteDataSource(AddCommentDataEnter addCommentDataEnter);
//react
Future<bool> addReactRemoteDataSource(ReactDataEnter reactDataEnter);
Future<bool> deleteReactRemoteDataSource(ReactDataEnter reactDataEnter);
//friends
Future<List<FriendDataModel>> getMyFriendsDataSource(FriendsDataEnter data);
Future<List<FriendDataModel>> getMySuggestionFriendsDataSource(FriendsDataEnter data);
Future<List<FriendDataModelForSendRequest>> getMyRequestsSendDataSource(FriendsDataEnter data);
Future<List<FriendDataModelForSendRequest>> getMyRequestReceiveDataSource(FriendsDataEnter data);
Future<bool> sendRequestDataSource (RequestDataEnter data);
Future<bool> acceptRequestDataSource (RequestDataEnter data);
Future<bool> cancelRequestDataSource (RequestDataEnter data);
//user
Future<bool> changeProfileImage (ChangeUserImageDataEnter data);
Future<bool> changeBackgroundImage (ChangeUserImageDataEnter data);

//chat
Future<List<DataChatReturnedModel>> getChatBetweenUser(DataChatEnter data);
}