import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moface/user/data/model/get_post_data_model.dart';
import 'package:moface/user/domin/entites/change_profile_data_enter.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/domin/entites/posts/react/react_data_enter.dart';
import 'package:moface/user/domin/entites/posts/user_view_posts.dart';
import 'package:moface/user/domin/usecase/delete_post_usecase.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/service_locator.dart';
import '../../../domin/entites/posts/comments/add_comment_data_enter.dart';
import '../../../domin/entites/posts/get_post_data_enter.dart';
import '../../../domin/entites/posts/post_data.dart';
import '../../../domin/entites/posts/post_data_enter.dart';
import '../../../domin/entites/userData.dart';
import '../../../domin/usecase/add_post_usecase.dart';
import '../../../domin/usecase/change_user_images.dart';
import '../../../domin/usecase/comments_usecase.dart';
import '../../../domin/usecase/get_post_data_usecase.dart';
import '../../../domin/usecase/reacts_manager_usercase.dart';
import '../../../domin/usecase/update_post_usecase.dart';
import '../../../domin/usecase/view_all_user_post_usecase.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState());




  XFile? selectedImage;
  FilePickerResult? selectedWebImage;
  XFile? selectedProfileImage;
  FilePickerResult? selectedWebProfileImage;
  XFile? selectedBackgroundImage;
  FilePickerResult? selectedWebBackgroundImage;
  List<GetPostData> userPosts = [];
  List<GetPostData> homePosts = [];

  TextEditingController textEditingControllerForComment =
      TextEditingController();
  TextEditingController textEditingControllerForUpdateComment =
      TextEditingController();
  TextEditingController textEditingControllerForAddPost =
      TextEditingController();
  TextEditingController textEditingControllerForUpdatePost =
      TextEditingController();

  List<CommentDataForGetPost> comments = [];
  List<React> reacts = [];
  bool isReact = false;






  addPost() async {
    final data = instance<AddPostUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;

    final result = await data.call(
      PostDataEnter(
          token: token,
          userId: id,
          text: textEditingControllerForAddPost.text,
          webImage: selectedWebImage,
          image: selectedImage == null ? '' : selectedImage!.path),
    );
    result.fold((l) => print(l), (r) {
      emit(AddPostState(r));
    });
  }

  addComments(int postId) async {
    final data = instance<AddCommentUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    final result = await data.call(AddCommentDataEnter(
      comment: textEditingControllerForComment.text,
      postId: postId,
      userId: id,
      token: token,
      commentId: 1,
    ));
    result.fold((l) => print(l), (r) {
      emit(AddCommentLoadedState(r));
    });
  }

  deletePost(int postId) async {
    emit(DeletePostLoadingState());
    final data = instance<DeletePostUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    final result = await data.call(
      DataEnterDeleteForPost(userId: id, postId: postId, token: token),
    );
    result.fold((l) {}, (r) {

      //userPosts.removeWhere((element) => element.post.id == postId);
      emit(DeletePostLoadedState());
    });
  }

  updatePost(int postId) async {
    emit(DeletePostLoadingState());
    final data = instance<UpdatePostUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    final result = await data.call(PostDataEnterForUpdate(
      token: token,
      postId: postId,
      userId: id,
      text: textEditingControllerForUpdatePost.text,
      webImage: selectedWebImage,
      image: selectedImage == null ? '' : selectedImage!.path,
    ));
    result.fold((l) {}, (r) {
      for (var element in userPosts) {
        if (postId == element.post.id) {
          element.post.image = r.image;
          element.post.text = r.text;
          element.post.time = r.time;
        }
      }
    });
    //emit(DeletePostLoadedState());
  }

  deleteComment(int postId, int commentId) async {
    emit(DeletePostLoadingState());
    final data = instance<DeleteCommentUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    final result = await data.call(AddCommentDataEnter(
      comment: null,
      postId: postId,
      userId: id,
      token: token,
      commentId: commentId,
    ));
    result.fold((l) {}, (r) {
      comments.removeWhere((element) => element.id == commentId);
    });
    //emit(DeletePostLoadedState());
  }

  updateComment(int postId, int commentId) async {
    emit(DeletePostLoadingState());
    final data = instance<UpdateCommentUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    final result = await data.call(AddCommentDataEnter(
      comment: textEditingControllerForUpdateComment.text,
      postId: postId,
      userId: id,
      token: token,
      commentId: commentId,
    ));
    result.fold((l) {}, (r) {
      for (var element in comments) {
        if (commentId == element.id) {
          element.commentext = r.comment.commentext;
        }
      }
    });
    //emit(DeletePostLoadedState());
  }

  addReact(int postId) async {
    emit(AddReactState(postId));
    final data = instance<AddReactUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String id = sharedpref.getString('id')!;
    String token = sharedpref.getString('token')!;
    final result = await data
        .call(ReactDataEnter(userId: id, postId: postId, token: token));
    result.fold((l) {}, (r) {
      // emit(AddReactState());
    });
  }

  removeReact(int postId) async {
    emit(DeleteReactState(postId));
    final data = instance<DeleteReactUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    final result = await data
        .call(ReactDataEnter(userId: id, postId: postId, token: token));
    result.fold((l) {}, (r) {
      // emit(DeleteReactState());
    });
  }

  changeProfileImage() async {
    final data = instance<ChangeProfileImageUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    Either<Failure, bool> result;
    if (kIsWeb) {
      result = await data.call(ChangeUserImageDataEnter(
          token: token, userId: id, webImage: selectedWebProfileImage));
      result.fold((l) {}, (r) {
        Uint8List? bytes = selectedWebProfileImage!.files.single.bytes;
        String base64String = base64Encode(bytes!);
        sharedpref.setString('photoImg', base64String);
        emit(ChangeProfileImageState(base64String));
      });
    } else {
      result = await data.call(ChangeUserImageDataEnter(
          token: token, userId: id, image: selectedProfileImage!.path ?? ""));
      result.fold((l) {}, (r) {
        sharedpref.setString('photoImg', selectedProfileImage!.path);
        emit(ChangeProfileImageState(selectedProfileImage!.path));
      });
    }
  }

  changeBackgroundImage() async {
    final data = instance<ChangeBackgroundImageUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String id = sharedpref.getString('id')!;
    Either<Failure, bool> result;
    if (kIsWeb) {
      result = await data.call(ChangeUserImageDataEnter(
          token: token, userId: id, webImage: selectedWebBackgroundImage));
      result.fold((l) {}, (r) {
        Uint8List? bytes = selectedWebBackgroundImage!.files.single.bytes;
        String base64String = base64Encode(bytes!);
        sharedpref.setString('backgroundImg', base64String);
        emit(ChangeBackgroundImageState(base64String));
      });
    } else {
      result = await data.call(ChangeUserImageDataEnter(
          token: token,
          userId: id,
          image: selectedBackgroundImage!.path ?? ""));
      result.fold((l) {}, (r) {
        sharedpref.setString('backgroundImg', selectedBackgroundImage!.path);
        emit(ChangeBackgroundImageState(selectedBackgroundImage!.path));
      });
    }
  }
}
