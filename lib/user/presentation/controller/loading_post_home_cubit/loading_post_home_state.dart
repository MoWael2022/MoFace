import '../../../domin/entites/posts/get_post_data.dart';

abstract class GetHomePostState {}

class InitState extends GetHomePostState {}

class HomeLoadMorePostsState extends GetHomePostState {
  GetPostData data;

  HomeLoadMorePostsState(this.data);
}

class HomeLoadingMorePostsState extends GetHomePostState {}

class LoadingPostHomeState extends GetHomePostState {}

class LoadedPostHomeState extends GetHomePostState {
  List<GetPostData> data;

  List<dynamic> postsId;

  LoadedPostHomeState(this.data, this.postsId);
}

class ErrorPostHomeState extends GetHomePostState {
  String message;

  ErrorPostHomeState(this.message);
}
