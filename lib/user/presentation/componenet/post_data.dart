import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/presentation/componenet/profile_post_component.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_cubit.dart';
import 'package:moface/user/presentation/controller/load_post_cubit/load_post_state.dart';

import '../../../core/constant.dart';
import '../../domin/entites/posts/get_post_data.dart';
import '../controller/load_post_cubit/load_post_cubit.dart';

class PostList extends StatefulWidget {
  final List<GetPostData> userPosts;

  const PostList({super.key, required this.userPosts});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<GetPostData> _previousState = [];

  @override
  Widget build(BuildContext context) {
    final loadPostCubit =BlocProvider.of<LoadPostCubit>(context);
    final appCubit =BlocProvider.of<AppCubit>(context);
    return BlocConsumer<LoadPostCubit , BaseLoadPostState>(
      listener: (context ,state){
        if (state is ProfileLoadMorePostsLoadingState) {
          loadPostCubit.isLoadingMore = true;
        } else if (state is ProfileLoadMorePostsState) {
          loadPostCubit.isLoadingMore = false;
          appCubit.userPosts.add(state.data);
        }
      },
      builder: (context ,state){
        return Column(
          children: [
            SizedBox(
              width: Constant.width(context) * .5,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appCubit.userPosts.length,
                itemBuilder: (context, index) {
                  return Column(
                    key: ValueKey(appCubit.userPosts[index].post.id), // Provide unique key for each post
                    children: [
                      Center(
                        child: ProfilePostComponent(
                          index: index,
                          post: appCubit.userPosts[index],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (loadPostCubit.isLoadingMore)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },

    );

  }
}
