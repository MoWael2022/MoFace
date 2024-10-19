
import '../../../domin/entites/posts/get_post_data.dart';
import '../../../domin/entites/userData.dart';

abstract class DataState{}

class LoadingState extends DataState{}
class LoadedUserData extends DataState{
  UserData userData;
  LoadedUserData(this.userData);
}


class ProfilePostsLoadedState extends DataState{
  List<GetPostData> data ;
  List<dynamic> postsId;
  ProfilePostsLoadedState(this.data,this.postsId);
}
class ProfilePostsLoadingState extends DataState{}

class ProfilePostsErrorState extends DataState{
  String messageError;
  ProfilePostsErrorState(this.messageError);
}

class LoadingSuggestionFriendsPage extends DataState{}

class LoadedSuggestionFriendsPage extends DataState{

}