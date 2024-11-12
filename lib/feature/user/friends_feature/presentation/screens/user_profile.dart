import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utilts/api_constant.dart';
import '../../../post_feature/main_post/domin/entites/get_post_data.dart';
import '../../../post_feature/main_post/presentation/controller/main_post_cubit/base_get_post_state.dart';
import '../../../post_feature/main_post/presentation/controller/main_post_cubit/get_profile_post_cubit.dart';
import '../../../post_feature/main_post/presentation/widgets/post.dart';
import '../../../post_feature/main_post/presentation/widgets/post_shimmer.dart';
import '../../../profile/presentation/widgets/bio_data_profile.dart';
import '../../../profile/presentation/widgets/proile_appbar_component.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final getProfilePostCubit = BlocProvider.of<GetProfilePostCubit>(context);
    return Container(
      color: Colors.white,
      width: Constant.width(context),
      child: ListView(
        controller: getProfilePostCubit.profileScrollController,
        children: [
          // BlocConsumer<GetProfilePostCubit, BaseGetPostState>(
          //     listener: (context, state) {
          //   if (state is LoadedInitPost) {
          //     getProfilePostCubit.isShimmer = false;
          //   }
          // }, builder: (context, state) {
          //   return ProfileAppBar(
          //     backgroundImage: getProfilePostCubit.currentUser!.profileImg,
          //     profileImage: getProfilePostCubit.currentUser!.profileImg,
          //     username: getProfilePostCubit.currentUser!.username,
          //     numberOfFriends: '600',
          //   ).redacted(
          //     redact: getProfilePostCubit.isShimmer,
          //     context: context,
          //     configuration: RedactedConfiguration(
          //       animationDuration: const Duration(milliseconds: 800),
          //     ),
          //   );
          // }),
          Stack(
            children: [
              BlocBuilder<GetProfilePostCubit, BaseGetPostState>(
                builder: (context, state) {
                  print(state);
                  print("rebuild profile bloc");
                  if (state is LoadingPostState) {
                    return SizedBox(
                      width: 55.w,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  PostShimmer(),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is ErrorOccurred) {
                    return Center(
                      child: Container(
                        width: 70.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(20),
                          border: const Border(
                            top: BorderSide(width: 7, color: Colors.grey),
                            // Top border
                            left: BorderSide(width: 7.0, color: Colors.grey),
                            // Left border
                            right: BorderSide(width: 7.0, color: Colors.grey),
                            // Right border
                            bottom: BorderSide(
                                width: 7.0,
                                color: Colors.grey), // Bottom border
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                state.errorMessage,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: 55.w,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        StreamBuilder<Set<GetPostData>>(
                          stream: getProfilePostCubit.profilePostsStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                width: 4.w,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    PostShimmer(),
                                  ],
                                ),
                              );
                            }
                            final posts = snapshot.data!;
                            return ListView.builder(
                              key: const PageStorageKey('profilePosts'),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: posts.length +
                                  (getProfilePostCubit.isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                //print("build");
                                if (index == posts.length) {
                                  // Show loading indicator at the end of the list
                                  return const Center(child: PostShimmer());
                                }
                                return Column(
                                  key: ValueKey(posts.elementAt(index).post.id),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Post(
                                      post: posts.elementAt(index),
                                      posts: posts.toList(),
                                      index: index,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        if (getProfilePostCubit.inBatch)
                          SizedBox(
                            width: 4.w,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                PostShimmer(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              // BlocBuilder<GetProfilePostCubit, BaseGetPostState>(
              //     builder: (context, state) {
              //   return Positioned(
              //     top: 0,
              //     right: 170,
              //     child: Padding(
              //       padding: EdgeInsets.all(Constant.width(context) * .01),
              //       child: Column(
              //         children: [
              //           BioDataProfile(
              //             numberOfFriends: 6,
              //             name: getProfilePostCubit.currentUser!.username,
              //             email: getProfilePostCubit.currentUser!.username,
              //             id: getProfilePostCubit.currentUser!.username,
              //             numberOfPosts:
              //                 getProfilePostCubit.postIds.postsId.length,
              //           ).redacted(
              //             redact: getProfilePostCubit.isShimmer,
              //             context: context,
              //             configuration: RedactedConfiguration(
              //               animationDuration:
              //                   const Duration(milliseconds: 800),
              //             ),
              //           ),
              //           SizedBox(
              //             height: Constant.height(context) * .07,
              //           ),
              //           // FriendBoxComponent(
              //           //   userId: widget.userData.id,
              //           //   isMyProfile: widget.isMyProfile,
              //           // ),
              //         ],
              //       ),
              //     ),
              //   );
              // }),
            ],
          )
        ],
      ),
    );
  }
}
