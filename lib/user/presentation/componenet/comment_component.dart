import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_cubit.dart';
import 'package:universal_html/html.dart';
import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';
import '../../data/model/get_post_data_model.dart';
import '../controller/app_cubit/app_state.dart';
import 'coment_text_form_fields.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);
    return Dialog(
      child: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AddCommentLoadedState) {
            cubit.textEditingControllerForComment.clear();
            cubit.comments.add(CommentDataForGetPostModel(
                commentext: state.comment.comment.commentext,
                id: state.comment.comment.id,
                userId: state.comment.user.id,
                userName: state.comment.user.userName,
                time: state.comment.comment.time,
                userImg: state.comment.user.profileimg));
          }
        },
        child:BlocBuilder<AppCubit,AppState>(
          builder: (context,state) {
            return SizedBox(
              height: Constant.height(context) * .8,
              width: Constant.width(context) * .4,
              child: cubit.comments.isEmpty
                  ? const Center(
                child: Text("No Comments"),
              )
                  : Column(
                children: [
                  Text(
                      "The Total Number of Comments ${cubit.comments.length.toString()}"),
                  SizedBox(
                    height: Constant.height(context) * .65,
                    width: Constant.width(context) * .37,
                    child: ListView.builder(
                        itemCount: cubit.comments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(
                                Constant.width(context) * .01),
                            child: CommentComponent(
                              comment: cubit.comments[index],
                              postId: postId,
                            ),
                          );
                        }),
                  ),
                  CommentTextFormFields(postId: postId),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class CommentComponent extends StatelessWidget {
  const CommentComponent({
    super.key,
    required this.postId,
    required this.comment,
  });

  final CommentDataForGetPost comment;
  final int postId;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Profile Image
        Padding(
          padding: EdgeInsets.all(Constant.width(context) * .01),
          child: CircleAvatar(
            radius: Constant.width(context) * .02,
            backgroundImage: comment.userImg == ""
                ? const NetworkImage(ImagePathManager.defaultProfileImage)
                : MemoryImage(base64Decode(comment.userImg)),
          ),
        ),

        // Comment content with Edit/Delete
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Constant.width(context) * .02,
                    right: Constant.width(context) * .12,
                    top: Constant.width(context) * .01,
                    bottom: Constant.width(context) * .01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Username
                      Text(
                        comment.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Comment Text
                      Padding(
                        padding: EdgeInsets.only(
                          top: Constant.width(context) * .01,
                        ),
                        child: Text(comment.commentext),
                      ),
                    ],
                  ),
                ),

                // Edit/Delete Dropdown Menu
                Positioned(
                  right: 0,
                  top: 0,
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        cubit.updateComment(postId, comment.id);
                      } else if (value == 'delete') {
                        cubit.deleteComment(postId, comment.id);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit Comment'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete Comment'),
                      ),
                    ],
                    child: Padding(
                      padding: EdgeInsets.all(Constant.width(context) * .02),
                      child: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
