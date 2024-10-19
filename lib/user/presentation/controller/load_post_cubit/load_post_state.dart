import '../../../domin/entites/posts/get_post_data.dart';

abstract class BaseLoadPostState {}


class InitState extends BaseLoadPostState{}
class ProfileLoadMorePostsState extends BaseLoadPostState{
  GetPostData data ;
  ProfileLoadMorePostsState(this.data);
}

class ProfileLoadMorePostsLoadingState extends BaseLoadPostState{}