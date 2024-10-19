import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/core/constant.dart';
import 'package:moface/user/domin/entites/posts/get_post_data.dart';
import 'package:moface/user/presentation/componenet/friend_box_component.dart';
import 'package:moface/user/presentation/componenet/profile_post_component.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_cubit.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_state.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_cubit.dart';
import 'package:moface/user/presentation/controller/load_post_cubit/load_post_cubit.dart';
import 'package:moface/user/presentation/controller/loading_post_home_cubit/loading_post_home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../../domin/entites/posts/comments/add_comment_data_returned.dart';
import '../componenet/add_post.dart';
import '../componenet/bio_data_profile.dart';
import '../componenet/post_data.dart';
import '../componenet/proile_appbar_component.dart';
import '../controller/loading_cubit/data_cubit.dart';
import '../controller/loading_cubit/data_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _scrollController;
  late DataCubit dataCubit; // Store DataCubit reference here
  late AppCubit appCubit; // S


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataCubit.getProfilePosts(context);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final cubit = BlocProvider.of<LoadPostCubit>(context);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!cubit.isLoadingMore) {
        cubit.loadPosts(); // Trigger load only if not already loading
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build profile");
    dataCubit = BlocProvider.of<DataCubit>(context);
    appCubit = BlocProvider.of<AppCubit>(context);
    final loadPostCubit = BlocProvider.of<LoadPostCubit>(context);
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        print("build profile");
        print(state);
        if (state is LoadingState || state is ProfilePostsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return BlocListener<AppCubit, AppState>(
          listener: (context, state) async {
            print(state);
            if (state is DeletePostLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false, // Prevent dismissing the dialog
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            } else if (state is DeletePostLoadedState) {
              Navigator.pop(context);
            } else if (state is ChangeBackgroundImageState) {
              dataCubit.userData!.backgroundImgge = state.backgroundImage;
            } else if (state is ChangeProfileImageState) {
              dataCubit.userData!.photoImage = state.profileImage;
            } else if (state is AddPostState) {
              loadPostCubit.postsId.clear();
              appCubit.userPosts.clear();
              await dataCubit.getProfilePosts(context);
              // cubit.userPosts.add(
              //   GetPostData(
              //       post: state.data,
              //       comments: [],
              //       isUserReact: false,
              //       reacts: [],
              //       message: "your Post",
              //       userPost: User(
              //           id: cubit.userData!.id,
              //           profileimg: cubit.userData!.photoImage,
              //           userName: cubit.userData!.name)),
              // );
            }
          },
          child: Container(
            color: Colors.white,
            width: Constant.width(context),
            child: ListView(
              controller: _scrollController,
              children: [
                ProfileAppBar(
                  backgroundImage: dataCubit.userData!.backgroundImgge,
                  profileImage: dataCubit.userData!.photoImage,
                  username: dataCubit.userData!.name,
                  numberOfFriends: '600',
                ),
                Padding(
                  padding: EdgeInsets.only(left: Constant.width(context) * .13),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Constant.width(context) * .02,
                            right: Constant.width(context) * .01),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddPostDialog(
                                    title: "Post",
                                    textEditingController: appCubit
                                        .textEditingControllerForAddPost,
                                  );
                                });
                          },
                          child: const Text("Add Post"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Constant.width(context) * .01),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Dialog(
                                    child: Text("hallo"),
                                  );
                                });
                          },
                          child: const Text("Update Profile"),
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: Constant.height(context) * .2),

                Stack(
                  children: [
                    BlocBuilder<DataCubit, DataState>(
                      builder: (context,state) {
                        if (state is ProfilePostsErrorState){
                          return SizedBox(
                            height: 70.h,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.messageError),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AddPostDialog(
                                              title: "Post",
                                              textEditingController: appCubit
                                                  .textEditingControllerForAddPost,
                                            );
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent, // Button color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12), // Rounded button
                                      ),
                                    ),
                                    child: const Text("Add post"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.white,
                            width: Constant.width(context) * .8,
                            child: Row(
                              children: [
                                PostList(
                                  userPosts: appCubit.userPosts,
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                    Positioned(
                      top: 0,
                      right: 170,
                      child: Padding(
                        padding: EdgeInsets.all(Constant.width(context) * .01),
                        child: Column(
                          children: [
                            BioDataProfile(
                              numberOfFriends: 6,
                              name: dataCubit.userData!.name,
                              email: dataCubit.userData!.email,
                              id: dataCubit.userData!.id,
                              numberOfPosts: appCubit.userPosts.length,
                            ),
                            SizedBox(
                              height: Constant.height(context) * .07,
                            ),
                            const FriendBoxComponent(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
