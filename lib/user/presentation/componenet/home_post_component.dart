import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/core/constant.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/presentation/componenet/coment_text_form_fields.dart';
import 'package:moface/user/presentation/componenet/post.dart';
import 'package:moface/user/presentation/componenet/react_component.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_state.dart';
import 'package:moface/user/presentation/controller/loading_post_home_cubit/loading_post_home_cubit.dart';

import '../../../core/global_resources/imagePathManager.dart';
import '../../data/model/get_post_data_model.dart';
import '../controller/app_cubit/app_cubit.dart';
import '../controller/app_cubit/app_state.dart';
import '../controller/app_cubit/app_state.dart';
import 'add_post.dart';
import 'comment_component.dart';

class HomePostComponent extends StatelessWidget {
  const HomePostComponent({
    super.key,
    required this.post,
    required this.index,
  });

  final GetPostData post;
  final int index;

  @override
  Widget build(BuildContext context) {
    //final cubit = BlocProvider.of<AppCubit>(context);
    final homePostCubit = BlocProvider.of<GetHomePostCubit>(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AddReactState && state.postId == post.post.id) {
          homePostCubit.homePosts[index].isUserReact = true;
        } else if (state is DeleteReactState && state.postId == post.post.id) {
          homePostCubit.homePosts[index].isUserReact = false;
        }
      },
      child: Post(
        post: post,
        index: index,
        posts: homePostCubit.homePosts,
      ),
    );
  }
}
