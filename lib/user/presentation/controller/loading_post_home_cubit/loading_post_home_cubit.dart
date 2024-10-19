import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:moface/user/presentation/controller/loading_post_home_cubit/loading_post_home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service_locator.dart';
import '../../../domin/entites/posts/get_post_data.dart';
import '../../../domin/entites/posts/get_post_data_enter.dart';
import '../../../domin/entites/posts/user_view_posts.dart';
import '../../../domin/usecase/get_post_data_usecase.dart';
import '../../../domin/usecase/get_post_with_my_friends_usecase.dart';
import '../../../domin/usecase/view_all_user_post_usecase.dart';

class GetHomePostCubit extends Cubit<GetHomePostState> {
  GetHomePostCubit() : super(InitState()) {
    scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getHomePosts();
    });
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }


  int currentNumberOfPost = 0;
  List<dynamic> postsId = [];
  bool isLoadingMore = false;
  List<GetPostData> homePosts = [];
  final ScrollController scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoadingMore) {
        loadPosts(); // Trigger load only if not already loading
      }
    }
  }

  loadPosts() async {
    print(postsId.length);
    print(currentNumberOfPost);
    if (postsId.length > currentNumberOfPost &&
        state is! HomeLoadingMorePostsState) {
      emit(HomeLoadingMorePostsState());
      final post = await getPostById(postsId[currentNumberOfPost]);

      currentNumberOfPost += 1;

      emit(HomeLoadMorePostsState(post));
    }
  }

  Future<GetPostData> getPostById(int id) async {
    GetPostData? post;
    final data = instance<GetPostDataUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result =
        await data.call(GetPostDataEnter(token: token, id: id, userId: idUser));
    result.fold((l) {
      emit(ErrorPostHomeState(l.messageError));
    }, (r) {
      post = r;
    });
    return post!;
  }

  initPosts() async {
    for (int i = 0; i < 4 && i < postsId.length; i++) {
      final post = await getPostById(postsId[i]);
      homePosts.add(post);
    }
    currentNumberOfPost = homePosts.length;
  }

  getHomePosts() async {
    emit(LoadingPostHomeState());
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    print(id);
    final result = instance<GetPostWithMyFriendsUseCase>();
    final data = await result.call(
      UserPostDataEnter(token: token, userId: id),
    );

    data.fold((l) {
      emit(ErrorPostHomeState(l.messageError));
    }, (r) async {
      postsId = r.postsId;
      if (homePosts.isEmpty) {
        await initPosts();
      }
      emit(LoadedPostHomeState(homePosts, r.postsId));
    });
  }
}
