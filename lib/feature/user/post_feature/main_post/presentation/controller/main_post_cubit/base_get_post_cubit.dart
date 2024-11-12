import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mo_face_app/core/user_data/user_data_provider.dart';
import 'package:mo_face_app/feature/auth_feature/domin/entites/user_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/get_post_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/postsIds.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/get%7Bpost_using_id_use_case.dart';

import '../../../../../../../core/local_data_source/secure_local_data.dart';
import 'base_get_post_state.dart';

abstract class BaseGetPostCubit extends Cubit<BaseGetPostState> {
  GetPostByIdUseCase getPostByIdUseCase;

  BaseGetPostCubit({required this.getPostByIdUseCase}) : super(InitState());

  UserData? user = UserDataProvider().userData;



  Future<void> getPostUsingId(
      int postID, Set<GetPostData> displayedPost) async {
    final data = await getPostByIdUseCase
        .call(DataForGetPostData(id: postID, userId: user!.id));

    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      displayedPost.add(r);
      //newPost.add(r);
      //inBatch = false ;
      //emit(LoadedMorePostsState(displayedPost));
    });
  }

  void fetchPosts({
    required int count,
    required Set<GetPostData> displayedPostData,
    required PostsIds postIds,
    required StreamController<Set<GetPostData>> streamController,
    required bool isLoadingMore,
  }) async {
    if (displayedPostData.length >= postIds.postsId.length) {
      return;
    }

    final idsToFetch =
        postIds.postsId.skip(displayedPostData.length).take(count).toList();


    isLoadingMore = true;

    for (int postId in idsToFetch) {
      await getPostUsingId(postId, displayedPostData);
    }

    // if (newPosts.isNotEmpty) {
    //   streamController.add(newPosts);
    // }
    streamController.add(displayedPostData);
    //inBatch = true;
    isLoadingMore = false;
  }

  void onScroll();
}
