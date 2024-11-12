import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/manage_profile_post.dart';

import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/utilts/api_constant.dart';
import '../../../post_feature/main_post/presentation/controller/main_post_cubit/get_profile_post_cubit.dart';
import 'add_post.dart';


class AddPostButton extends StatelessWidget {
  const AddPostButton({super.key});

  @override
  Widget build(BuildContext context) {
    final getProfilePostCubit = BlocProvider.of<ManageProfilePost>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: Constant.width(context) * .02,
        right: Constant.width(context) * .01,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddPostDialog(
                managePostCubit: getProfilePostCubit,
                title: "Post",
                textEditingController: getProfilePostCubit.textAddPostEditingController,
              );
            },
          );
        },
        child: const Text("Add Post"),
      ),
    );
  }
}


