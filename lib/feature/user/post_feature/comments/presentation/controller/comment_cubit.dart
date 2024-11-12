import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/entites/add_comment_data_enter.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/entites/add_comment_data_returned.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/usecase/add_comment_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/usecase/delete_comment_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/domin/usecase/update_comment_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/presentation/controller/comment_state.dart';

import '../../../../../../core/local_data_source/secure_local_data.dart';
import '../../../../../../core/user_data/user_data_provider.dart';
import '../../domin/entites/comment_data_for_post.dart';

class CommentCubit extends Cubit<CommentState> {
  AddCommentUseCase addCommentUseCase;
  DeleteCommentUseCase deleteCommentUseCase;
  UpdateCommentUseCase updateCommentUseCase;

  CommentCubit(
      {required this.updateCommentUseCase,
      required this.deleteCommentUseCase,
      required this.addCommentUseCase})
      : super(InitState());

  TextEditingController textCommentEditingController = TextEditingController();
  TextEditingController textCommentUpdateEditingController =
      TextEditingController();
  final userId  = UserDataProvider().userData!.id;


  final StreamController<List<CommentDataForGetPost>> _commentController = StreamController<List<CommentDataForGetPost>>();

  Stream<List<CommentDataForGetPost>> get commentStream => _commentController.stream;

  List<CommentDataForGetPost> comments = [];

  initComment(List<CommentDataForGetPost> data){
    comments = data;
    _commentController.add(comments);
  }



  void addComment(int postId) async {
    emit(CommentLoadingState());
    final data = await addCommentUseCase.call(
      CommentDataEnter(
          comment: textCommentEditingController.text,
          userId: userId,
          postId: postId,
          commentId: 1),
    );
    data.fold((l) {
      emit(CommentErrorState(l.message));
    }, (r) {
      comments.add(r.convertToCommentDataForPost());
      _commentController.add(comments);
      textCommentEditingController.clear();
    });
  }

  void deleteComment(int postId, int commentId) async {
    emit(CommentLoadingState());
    final data = await deleteCommentUseCase.call(
      CommentDataEnter(
          comment: null, userId: userId, postId: postId, commentId: commentId),
    );
    data.fold((l) {
      emit(CommentErrorState(l.message));
    }, (r) {
      comments.removeWhere((comment) => r.comment.id == comment.id);
      _commentController.add(comments);
    });
  }

  void updateComment(int postId, commentId) async {
    emit(CommentLoadingState());
    final data = await updateCommentUseCase.call(
      CommentDataEnter(
          comment: textCommentUpdateEditingController.text,
          userId: userId,
          postId: postId,
          commentId: commentId),
    );
    data.fold((l) {
      emit(CommentErrorState(l.message));
    }, (r) {
      comments.add(r.convertToCommentDataForPost());
      _commentController.add(comments);
    });
  }

  @override
  Future<void> close() {
    _commentController.close();
    return super.close();
  }
}
