import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/core/service_locator/service_locator.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/presentation/controller/comment_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/presentation/controller/comment_state.dart';
import '../../../../../../core/component/imagePathManager.dart';
import '../../../../../../core/utilts/api_constant.dart';
import '../../../../../../core/utilts/functions.dart';
import '../../domin/entites/comment_data_for_post.dart';
import 'coment_text_form_fields.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, required this.postId,required this.comments});

  final int postId;
  final List<CommentDataForGetPost> comments;

  @override
  Widget build(BuildContext context) {
    //final cubit = BlocProvider.of<CommentCubit>(context);
    return BlocProvider(
      create: (context)=>instance<CommentCubit>()..initComment(comments),
      child: Dialog(
        child: BlocBuilder<CommentCubit, CommentState>(builder: (context, state) {
          return StreamBuilder<List<CommentDataForGetPost>>(
            stream: BlocProvider.of<CommentCubit>(context).commentStream,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }
              return SizedBox(
                  height: Constant.height(context) * .8,
                  width: Constant.width(context) * .4,
                  child: Column(
                    children: [
                      snapshot.data!.isEmpty
                          ? const Center(
                              child: Text("No Comments"),
                            )
                          : Column(
                              children: [
                                Text(
                                    "The Total Number of Comments "),
                                SizedBox(
                                  height: Constant.height(context) * .65,
                                  width: Constant.width(context) * .37,
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(
                                              Constant.width(context) * .01),
                                          child: CommentComponent(
                                            comment: snapshot.data![index],
                                            postId: postId,
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                      CommentTextFormFields(postId: postId),
                    ],
                  ));
            }
          );
        }),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Profile Image
        Padding(
          padding: EdgeInsets.all(Constant.width(context) * .01),
          child: CircleAvatar(
            radius: Constant.width(context) * .02,
            backgroundImage: Functions.getUserImage(comment.userImg),
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
                        BlocProvider.of<CommentCubit>(context).updateComment(postId, comment.id);
                      } else if (value == 'delete') {
                        BlocProvider.of<CommentCubit>(context).deleteComment(postId, comment.id);
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
