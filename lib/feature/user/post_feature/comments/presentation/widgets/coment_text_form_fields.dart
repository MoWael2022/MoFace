import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/core/user_data/user_data_provider.dart';
import 'package:mo_face_app/feature/user/post_feature/comments/presentation/controller/comment_cubit.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/widgets/user_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/component/imagePathManager.dart';
import '../../../../../../core/utilts/api_constant.dart';

class CommentTextFormFields extends StatefulWidget {
  const CommentTextFormFields({super.key, required this.postId});

  final int postId;

  @override
  State<CommentTextFormFields> createState() => _CommentTextFormFieldsState();
}

class _CommentTextFormFieldsState extends State<CommentTextFormFields> {
  final userData = UserDataProvider().userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constant.width(context) * .01),
      child: Row(
        children: [
          UserImage(
            image: userData!.photoImage,
          ),
          SizedBox(
            width: Constant.width(context) * .01,
          ),
          Expanded(
            child: TextField(
              controller: BlocProvider.of<CommentCubit>(context).textCommentEditingController,
              decoration:const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a comment...',
              ),
            ),
          ),
          SizedBox(width: Constant.width(context) * .02),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              BlocProvider.of<CommentCubit>(context).addComment(widget.postId);
            },
          ),
        ],
      ),
    );
  }
}
