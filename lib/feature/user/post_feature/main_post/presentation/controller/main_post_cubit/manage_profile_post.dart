import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_add_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_delete_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/entites/data_for_update_post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/add_post_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/delete_post_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/domin/usecase/update_post_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/base_get_post_state.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/get_profile_post_cubit.dart';

import '../../../domin/entites/get_post_data.dart';
import '../../../domin/entites/user_data_for_post.dart';

class ManageProfilePost extends GetProfilePostCubit {
  AddPostUseCase addPostUseCase;
  DeletePostUseCase deletePostUseCase;
  UpdatePostUseCase updatePostUseCase;

  ManageProfilePost(
      {required super.getPostByIdUseCase,
      required super.profilePostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase,
      required this.addPostUseCase});

  TextEditingController textAddPostEditingController = TextEditingController();
  TextEditingController textUpdatePostEditingController =
      TextEditingController();
  XFile? selectedImage;
  FilePickerResult? selectedWebImage;

  addPost() async {
    final data = await addPostUseCase.call(
      DataForAddPost(
        userId: user!.id,
        text: textAddPostEditingController.text,
        image: selectedImage == null ? '' : selectedImage!.path,
        webImage: selectedWebImage,
        color: Colors.white,
      ),
    );
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      GetPostData data = GetPostData.convertFromPostData(
          r,
          User(
              id: user!.id,
              userName: user!.name,
              profileimg: user!.photoImage));

      emit(PostAddedState(data));
    });
  }

  void deletePost(int postId) async {
    final data = await deletePostUseCase
        .call(DataForDeletePost(userId: user!.id, postId: postId));
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      //deleteStream(postId);
      emit(PostDeletedState(postId));
    });
  }

  void updatePost(int postId) async {
    final data = await updatePostUseCase.call(
      DataForUpdatePost(
        postId: postId,
        color: Colors.white,
        userId: user!.id,
        text: textUpdatePostEditingController.text,
        image: selectedImage == null ? '' : selectedImage!.path,
        webImage: selectedWebImage,
      ),
    );
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      GetPostData data = GetPostData.convertFromPostData(
        r,
        User(id: user!.id, userName: user!.name, profileimg: user!.photoImage),
      );

      emit(PostUpdatedState(data));
    });
  }
}
