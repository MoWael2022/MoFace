import 'package:moface/user/domin/entites/friends/friend_data.dart';

abstract class BaseFriendsState {}

class InitState extends BaseFriendsState{}



class LoadingSuggestionFriends extends BaseFriendsState{}

class LoadedSuggestionFriends extends BaseFriendsState{
  List<FriendData> suggestionFriends;
  LoadedSuggestionFriends(this.suggestionFriends);
}

class LoadMyFriends extends BaseFriendsState {
  List<FriendData> myFriends;
  LoadMyFriends(this.myFriends);
}

class LoadingMyFriends extends BaseFriendsState{}


class LoadingSendRequestFriends extends BaseFriendsState{}

class LoadedSendRequestFriends extends BaseFriendsState{
  List<FriendData> myFriends;
  LoadedSendRequestFriends(this.myFriends);
}


class LoadingWaitingRequestFriends extends BaseFriendsState{}

class LoadedWaitingRequestFriends extends BaseFriendsState{
  List<FriendData> myFriends;
  LoadedWaitingRequestFriends(this.myFriends);
}


class SendRequestState extends BaseFriendsState{}

class AcceptRequestState extends BaseFriendsState{}

class CancelRequestState extends BaseFriendsState{
  String id ;
  CancelRequestState(this.id);
}

