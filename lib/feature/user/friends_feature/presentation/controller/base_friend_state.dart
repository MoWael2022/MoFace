import 'package:mo_face_app/feature/user/friends_feature/domin/entites/friend_data.dart';

abstract class BaseFriendState {}

class InitState extends BaseFriendState {}

class LoadingFriendState extends BaseFriendState {}

class LoadedMyFriendsState extends BaseFriendState {
  List<FriendData> data;

  LoadedMyFriendsState(this.data);
}

class LoadedSuggestionFriendsState extends BaseFriendState {
  List<FriendData> data;

  LoadedSuggestionFriendsState(this.data);
}

class LoadedMySendRequestsState extends BaseFriendState {
  List<FriendData> data;

  LoadedMySendRequestsState(this.data);
}

class LoadedMyReceiveRequestState extends BaseFriendState {
  List<FriendData> data;

  LoadedMyReceiveRequestState(this.data);
}

class CancelRequestState extends BaseFriendState {}

class AcceptRequestState extends BaseFriendState {}

class SendRequestState extends BaseFriendState {
  String friendId ;
  SendRequestState(this.friendId);
}

class ErrorOccurred extends BaseFriendState {
  String message;

  ErrorOccurred(this.message);
}
