import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/core/functions/functions.dart';
import 'package:moface/generated/intl/messages_en.dart';
import 'package:moface/user/presentation/controller/chat_cubit/chat_cubit.dart';
import 'package:moface/user/presentation/controller/chat_cubit/chat_state.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_state.dart';
import 'package:sizer/sizer.dart';
import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';
import '../../../core/router.dart';
import '../componenet/chat_component.dart';
import '../controller/friends_state/friends_cubit.dart';
import '../controller/loading_cubit/data_cubit.dart';
import '../controller/loading_post_home_cubit/loading_post_home_cubit.dart';
import '../controller/loading_post_home_cubit/loading_post_home_state.dart';
import '../componenet/home_post_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsCubit = BlocProvider.of<FriendsCubit>(context);
    final dataCubit = BlocProvider.of<DataCubit>(context);
    final homePostCubit = BlocProvider.of<GetHomePostCubit>(context);
    final chatCubit = BlocProvider.of<ChatCubit>(context);

    return BlocConsumer<GetHomePostCubit, GetHomePostState>(
      listener: (context, state) {
        if (state is LoadedPostHomeState) {
          homePostCubit.homePosts = state.data;
        }
        if (state is HomeLoadingMorePostsState) {
          homePostCubit.isLoadingMore = true;
        } else if (state is HomeLoadMorePostsState) {
          homePostCubit.isLoadingMore = false;
          homePostCubit.homePosts.add(state.data);
        }
      },
      builder: (context, state) {
        if (state is LoadingPostHomeState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorPostHomeState) {
          return SizedBox(
            height: 100.h,
            width: 50.w,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routers.suggestionFriends);
                      friendsCubit.getSuggestionFriends();
                      dataCubit.showSuggestionsScreen = true;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Suggest Friends"),
                  ),
                ],
              ),
            ),
          );
        }

        return Stack(
          children: [
            Row(
              children: [
                // Left side: Friends List
                Padding(
                  padding: EdgeInsets.all(1.0.w),
                  child: Container(
                    width: 20.w, // Adjust this based on your layout preference
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Friends',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        BlocListener<ChatCubit, ChatState>(
                          listener: (context, state) {
                            if (state is ShowDialogState) {
                              friendsCubit.showDialogs = true;
                            } else if (state is HideDialogsState) {
                              friendsCubit.showDialogs = false;
                            }
                          },
                          child: BlocBuilder<FriendsCubit, BaseFriendsState>(
                              builder: (context, state) {
                            if (state is LoadingMyFriends) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is LoadMyFriends) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: state.myFriends.length,
                                  // Mock friend count
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(1.0.w),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              Functions.getUserImage(state
                                                  .myFriends[index].profileImg),
                                        ),
                                        title: Text(
                                            state.myFriends[index].username),
                                        onTap: () {
                                          chatCubit.showDialogsMethod(
                                              state.myFriends[index]);
                                          chatCubit.getMessageBetweenUsers(state.myFriends[index].id);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              print(state);
                              return const Center(
                                child: Text('Unknown State'),
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),

                // Main content: Posts and Loading More
                Expanded(
                  child: ListView(
                    controller: homePostCubit.scrollController,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homePostCubit.homePosts.length,
                        itemBuilder: (context, index) {
                          return Column(
                            key: ValueKey(
                                homePostCubit.homePosts[index].post.id),
                            children: [
                              HomePostComponent(
                                index: index,
                                post: homePostCubit.homePosts[index],
                              ),
                            ],
                          );
                        },
                      ),
                      if (homePostCubit.isLoadingMore)
                        SizedBox(
                          width: 5.w,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatMessageReceived) {
                  if(state.message.arguments[2] != null){
                    chatCubit.allMessages.add({
                    "message" :state.message.arguments[2],
                    "isReceived":true,
                    });
                  }
                }else if (state is ChatMessageSent){
                  chatCubit.allMessages.add({
                    "message" :state.message,
                    "isReceived":false,
                  });
                }
              },
              builder: (context, state) {
                if (friendsCubit.showDialogs) {
                  return const Positioned(
                    bottom: 2,
                    left: 2,
                    child: ChatComponent(),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        );
      },
    );
  }
}
