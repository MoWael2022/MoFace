import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/domin/entites/posts/post_data.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';
import '../../domin/entites/posts/comments/add_comment_data_returned.dart';

class CommentTextFormFields extends StatefulWidget {
  const CommentTextFormFields({super.key,required this.postId});

  final int postId;

  @override
  State<CommentTextFormFields> createState() => _CommentTextFormFieldsState();
}

class _CommentTextFormFieldsState extends State<CommentTextFormFields> {
  List<Future<String>>? data;

  Future<String> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("photoImg") as String;
  }

  @override
  void initState() {
    data = [getProfileImage()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constant.width(context) * .01),
      child: Row(
        children: [
          FutureBuilder<List<String?>>(
              future: Future.wait(data!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: Constant.width(context) * .013,
                    backgroundImage: snapshot.data![0] == ""||snapshot.data![0] == "ChQeKDI="
                        ? const NetworkImage(
                        ImagePathManager.defaultProfileImage)
                        : MemoryImage(base64Decode(snapshot.data![0]!)),
                  );
                } else {
                  return CircleAvatar(
                      radius: Constant.width(context) * .013,
                      backgroundImage: const NetworkImage(
                          ImagePathManager.defaultProfileImage));
                }
              }),
          SizedBox(
            width: Constant.width(context) * .01,
          ),
          Expanded(
            child: TextField(
              controller: BlocProvider.of<AppCubit>(context).textEditingControllerForComment,
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
              BlocProvider.of<AppCubit>(context).addComments(widget.postId);
            },
          ),
        ],
      ),
    );
  }
}
