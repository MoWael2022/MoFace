import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/entites/friend_data.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_get_post_Ids.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/profile_post_use_case.dart';

import '../../../domin/entites/data_for_add_post.dart';
import '../../../domin/entites/data_for_delete_post.dart';
import '../../../domin/entites/data_for_update_post.dart';
import '../../../domin/entites/get_post_data.dart';
import '../../../domin/entites/postsIds.dart';
import '../../../domin/entites/user_data_for_post.dart';
import '../../../domin/usecase/add_post_use_case.dart';
import '../../../domin/usecase/delete_post_use_case.dart';
import '../../../domin/usecase/update_post_use_case.dart';
import 'base_get_post_cubit.dart';
import 'base_get_post_state.dart';

class GetProfilePostCubit extends BaseGetPostCubit {
  GetProfilePostUseCase profilePostUseCase;


  GetProfilePostCubit(
      {required super.getPostByIdUseCase, required this.profilePostUseCase}) {
    getProfilePostPost();
    profileScrollController.addListener(onScroll);
  }

  final StreamController<Set<GetPostData>> _postsProfileController =
      StreamController<Set<GetPostData>>.broadcast();

  set setStream(GetPostData getPostData) {
    final tempList = displayedProfilePostData.toList();
    tempList.insert(0, getPostData); // Insert at the beginning
    displayedProfilePostData = tempList.toSet();
    _postsProfileController.add(displayedProfilePostData);
  }

  set updateStream(GetPostData getPostData) {
    final tempList = displayedProfilePostData.toList();
    final index = tempList
        .indexWhere((element) => element.post.id == getPostData.post.id);

    // If the element exists, replace it at the same index
    if (index != -1) {
      tempList
        ..removeAt(index) // Remove the old element
        ..insert(
            index, getPostData); // Insert the new element at the same index
    } else {
      // If it doesn't exist, just add it to the list
      tempList.add(getPostData);
    }
    displayedProfilePostData = tempList.toSet();
    // Emit the updated list to the stream controller
    _postsProfileController.add(displayedProfilePostData);
  }

  Stream<Set<GetPostData>> get profilePostsStream =>
      _postsProfileController.stream;

  deleteStream(int postId) {
    displayedProfilePostData
        .removeWhere((element) => element.post.id == postId);
    _postsProfileController.add(displayedProfilePostData);
  }

  updatedStream(GetPostData getPostData) {
    displayedProfilePostData
        .removeWhere((element) => element.post.id == getPostData.post.id);
    displayedProfilePostData.add(getPostData);
    _postsProfileController.add(displayedProfilePostData);
  }

  ScrollController profileScrollController = ScrollController();

  bool inBatch = true;
  bool isShimmer = true;

  final int batchSize = 3; // Define batch size for pagination
  Set<GetPostData> displayedProfilePostData = {};
  PostsIds postIds = const PostsIds(postsId: []);
  bool isLoadingMore = false;

  void _loadInitialPosts() {
    fetchPosts(
      count: batchSize,
      displayedPostData: displayedProfilePostData,
      isLoadingMore: isLoadingMore,
      postIds: postIds,
      streamController: _postsProfileController,
    );
    print(displayedProfilePostData);
    emit(LoadedInitPost(displayedProfilePostData));
  }

  getProfilePostPost() async {
    emit(LoadingPostState());
    final data =
        await profilePostUseCase.call(DataForGetPostIds(userId:user!.id));
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
    profileScrollController.removeListener(onScroll);
    profileScrollController.dispose();
    _postsProfileController.close();
    return super.close();
  }

  @override
  void onScroll() {
    if (profileScrollController.position.pixels >=
            profileScrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      //isLoadingMore = true;
      fetchPosts(
        count: batchSize,
        displayedPostData: displayedProfilePostData,
        isLoadingMore: isLoadingMore,
        postIds: postIds,
        streamController: _postsProfileController,
      );
    }
  }

// addPost() async {
//
//   final data = await addPostUseCase.call(
//     DataForAddPost(
//       userId: user!.id,
//       text: textAddPostEditingController.text,
//       image: selectedImage == null ? '' : selectedImage!.path,
//       webImage: selectedWebImage,
//       color: Colors.white,
//     ),
//   );
//   data.fold((l) {
//     emit(ErrorOccurred(l.message));
//   }, (r) {
//     setStream = GetPostData.convertFromPostData(
//         r,
//         User(
//             id: user!.id,
//             userName: user!.name,
//             profileimg: user!.photoImage));
//
//     emit(PostAddedState());
//   });
// }

// void deletePost(int postId) async {
//   final data = await deletePostUseCase
//       .call(DataForDeletePost(userId: user!.id, postId: postId));
//   data.fold((l) {
//     emit(ErrorOccurred(l.message));
//   }, (r) {
//     //deleteStream(postId);
//     emit(PostDeletedState());
//   });
// }

// void updatePost(int postId) async {
//   final data = await updatePostUseCase.call(
//     DataForUpdatePost(
//       postId: postId,
//       userId: user!.id,
//       text: textUpdatePostEditingController.text,
//       image: selectedImage == null ? '' : selectedImage!.path,
//       webImage: selectedWebImage,
//       color: Colors.white
//     ),
//   );
//   data.fold((l) {
//     emit(ErrorOccurred(l.message));
//   }, (r) {
//     // updatedStream(
//     //   GetPostData.convertFromPostData(
//     //     r,
//     //     User(
//     //         id: user!.id, userName: user!.name, profileimg: user!.photoImage),
//     //   ),
//     // );
//     emit(PostUpdatedState());
//   });
// }
}
