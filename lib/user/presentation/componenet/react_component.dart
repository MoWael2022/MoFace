import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';
import '../../domin/entites/posts/get_post_data.dart';

class ReactClass extends StatelessWidget {
  const ReactClass({super.key, required this.post});

  final GetPostData post;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: Constant.height(context) * .8,
        width: Constant.width(context) * .4,
        child: post.reacts.isEmpty
            ? const Center(
                child: Text("No React"),
              )
            : Column(
                children: [
                  Text(
                      "The Total Number of React ${post.post.numOfReact.toString()}"),
                  SizedBox(
                    height: Constant.height(context) * .65,
                    width: Constant.width(context) * .37,
                    child: ListView(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: post.reacts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(
                                    Constant.width(context) * .01),
                                child:
                                    ReactComponent(react: post.reacts[index]),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ReactComponent extends StatelessWidget {
  const ReactComponent({super.key, required this.react});

  final React react;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(Constant.width(context) * .01),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: Constant.width(context) * .02,
                backgroundImage: react.profileimg == ""
                    ? const NetworkImage(ImagePathManager.defaultProfileImage)
                    : MemoryImage(
                        base64Decode(react.profileimg),
                      ),
              ),
              const Positioned(
                  bottom: -5,
                  right: -2,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
        Text(
          react.userName,
          style: TextStyle(
              fontSize: Constant.width(context) * .02, color: Colors.black),
        ),
      ],
    );
  }
}
