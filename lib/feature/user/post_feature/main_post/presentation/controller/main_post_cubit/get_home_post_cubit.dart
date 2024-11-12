import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_Ids.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/get_post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/postsIds.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/home_post_use_case.dart';

import '../../../../../../../core/local_data_source/secure_local_data.dart';
import 'base_get_post_cubit.dart';
import 'base_get_post_state.dart';

class GetHomePostCubit extends BaseGetPostCubit {
  HomePostUseCase homePostUseCase;

  GetHomePostCubit(
      {required super.getPostByIdUseCase, required this.homePostUseCase}) {
    getHomePost();
    homeScrollController.addListener(onScroll);
  }

  final StreamController<Set<GetPostData>> _postsHomeController =
      StreamController<Set<GetPostData>>.broadcast();

  bool inBatch = true;

  bool isShimmer = true;

  Stream<Set<GetPostData>> get postsStream => _postsHomeController.stream;

  ScrollController homeScrollController = ScrollController();
  final int batchSize = 4; // Define batch size for pagination
  Set<GetPostData> displayedHomePostData = {};
  PostsIds postIds = const PostsIds(postsId: []);
  bool isLoadingMore = false;

  void _loadInitialPosts() {
    fetchPosts(
      count: batchSize,
      displayedPostData: displayedHomePostData,
      isLoadingMore: isLoadingMore,
      postIds: postIds,
      streamController: _postsHomeController,
    );
    emit(LoadedInitPost(displayedHomePostData));
  }

  void getHomePost() async {
    emit(LoadingPostState());
    final data = await homePostUseCase.call(DataForGetPostIds(userId: user!.id));
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      postIds = r;
      _loadInitialPosts();
      //emit(LoadedPostIdsState(r));
    });
  }

  @override
  Future<void> close() {
    homeScrollController.removeListener(onScroll);
    homeScrollController.dispose();
    _postsHomeController.close();
    return super.close();
  }

  @override
  void onScroll() {
    if (homeScrollController.position.pixels >=
            homeScrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      //isLoadingMore = true;
      fetchPosts(
        count: batchSize,
        displayedPostData: displayedHomePostData,
        isLoadingMore: isLoadingMore,
        postIds: postIds,
        streamController: _postsHomeController,
      );
    }
  }
}
