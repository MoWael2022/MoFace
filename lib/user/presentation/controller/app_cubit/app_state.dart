import 'package:moface/user/domin/entites/posts/comments/add_comment_data_returned.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/domin/entites/posts/user_posts.dart';

import '../../../domin/entites/posts/post_data.dart';
import '../../../domin/entites/userData.dart';

abstract class AppState {}

class InitState extends AppState{}




class AddPostState extends AppState{
  PostData data ;
  AddPostState(this.data);
}




class AddCommentLoadingState extends AppState{}
class AddCommentLoadedState extends AppState{
  AddCommentReturnedData comment ;
  AddCommentLoadedState(this.comment);
}
class AddCommentErrorState extends AppState{}


class DeletePostLoadingState extends AppState{}
class DeletePostLoadedState extends AppState{

}

class AddReactState extends AppState{
  int postId ;
  AddReactState(this.postId);
}
class DeleteReactState extends AppState{
  int postId ;
  DeleteReactState(this.postId);
}


class UserDataUpdatedState extends AppState{
  UserData userData;
  UserDataUpdatedState(this.userData);
}
class ChangeBackgroundImageState extends AppState {
  String backgroundImage ;
  ChangeBackgroundImageState(this.backgroundImage);
}

class ChangeProfileImageState extends AppState {
  String profileImage;
  ChangeProfileImageState(this.profileImage);
}

