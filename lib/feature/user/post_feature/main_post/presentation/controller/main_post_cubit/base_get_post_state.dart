import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/postsIds.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/widgets/post.dart';

import '../../../domin/entites/get_post_data.dart';

abstract class BaseGetPostState {}

class InitState extends BaseGetPostState {}

// get list of posts states
class LoadingPostState extends BaseGetPostState {}

class ErrorOccurred extends BaseGetPostState {
  String errorMessage;

  ErrorOccurred(this.errorMessage);
}

class LoadedInitPost extends BaseGetPostState {
  Set<GetPostData> data;

  LoadedInitPost(this.data);
}

//loading more post data states

class LoadingMorePostState extends BaseGetPostState {}

class LoadedMorePostsState extends BaseGetPostState {
  List<GetPostData> data;

  LoadedMorePostsState(this.data);
}

class PostDeletedState extends BaseGetPostState {
  int postId;
  PostDeletedState(this.postId);
}

class PostUpdatedState extends BaseGetPostState {
  GetPostData getPostData ;
  PostUpdatedState(this.getPostData);
}

class PostAddedState extends BaseGetPostState {
  GetPostData getPostData ;
  PostAddedState(this.getPostData);
}
