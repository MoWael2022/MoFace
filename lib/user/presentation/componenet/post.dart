import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';
import '../../domin/entites/posts/get_post_data.dart';
import '../controller/app_cubit/app_cubit.dart';
import '../controller/app_cubit/app_state.dart';
import 'add_post.dart';
import 'coment_text_form_fields.dart';
import 'comment_component.dart';

class Post extends StatelessWidget {
  const Post({super.key,required this.post ,required this.index,required this.posts});

  final GetPostData post;
  final int index;
  final List<GetPostData> posts ;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);
    return Padding(
      padding: EdgeInsets.all(Constant.width(context) * .01),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Light grey background color
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        width: Constant.width(context) * .4,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Constant.width(context) * .01,
                bottom: Constant.width(context) * .03,
                left: Constant.width(context) * .03,
                right: Constant.width(context) * .01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: Constant.width(context) * .015,
                        backgroundImage: post.userPost.profileimg.isEmpty || post.userPost.profileimg =="ChQeKDI="
                            ? const NetworkImage(
                            ImagePathManager.defaultProfileImage)
                            : MemoryImage(
                            base64Decode(post.userPost.profileimg)),
                      ),
                      SizedBox(width: Constant.width(context) * .01),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.userPost.userName,
                            style: TextStyle(
                              fontSize: Constant.width(context) * .011,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            post.post.time,
                            style: TextStyle(
                              fontSize: Constant.width(context) * .01,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: PopupMenuButton<String>(
                      tooltip: "show Setting",
                      icon: const Icon(Icons.menu),
                      onSelected: (value) {
                        if (value == 'delete') {
                          cubit.deletePost(post.post.id);
                        } else if (value == 'update') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddPostDialog(
                                  title: "Update",
                                  textEditingController: cubit
                                      .textEditingControllerForUpdatePost,
                                  postId: post.post.id,
                                );
                              });
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'update',
                          child: Text('Update Post'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete Post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (post.post.image != null)
              Text(
                post.post.text,
                textAlign: TextAlign.start,
              ),
            Container(
              color: Colors.blueGrey,
              width: Constant.width(context) * .35,
              height: Constant.height(context) * .45,
              child: post.post.image == null
                  ? _textContainer(
                  post.post.text,
                  Constant.width(context) * .01,
                  Constant.width(context) * .02)
                  : _imageContainer(post.post.image!),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Constant.width(context) * .03,
                right: Constant.width(context) * .03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text(post.post.numOfReact.toString()),
                    ],
                  ),
                  BlocBuilder<AppCubit,AppState>(
                      builder: (context,state) {
                        return Text("${cubit.comments.length.toString()} comments");
                      }
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: Constant.width(context) * .133,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () {
                      if (posts[index].isUserReact) {
                        cubit.removeReact(post.post.id);
                      } else {
                        cubit.addReact(post.post.id);
                      }
                    },
                    child: BlocBuilder<AppCubit, AppState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              posts[index].isUserReact
                                  ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                                  : const Icon(Icons.favorite_border),
                              const Text('React'),
                            ],
                          );
                        }),
                  ),
                ),
                _button("Comment", context, () {
                  cubit.comments = post.comments;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Comment(postId: post.post.id);
                    },
                  );
                }, Icons.comment, false),
                _button("Share", context, () {}, Icons.share, false),
              ],
            ),
            CommentTextFormFields(postId: post.post.id),
          ],
        ),
      ),
    );
  }
}


Widget _textContainer(String text, paddingSize, fontSize) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

Widget _imageContainer(final String img) {
  print("build");
  return Image.memory(base64Decode(img), fit: BoxFit.fill);
}

Widget _button(String text, BuildContext context, VoidCallback onPressed,
    IconData icon, isReact) {
  return SizedBox(
    width: Constant.width(context) * .133,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: !isReact ? Colors.grey[200] : Colors.redAccent,
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
    ),
  );
}