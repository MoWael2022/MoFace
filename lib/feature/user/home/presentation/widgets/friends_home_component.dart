import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_friend_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_suggestion_friend_cubit.dart';
import 'package:redacted/redacted.dart';
import 'package:sizer/sizer.dart';

import '../../../friends_feature/presentation/controller/base_friend_state.dart';

import 'friend_tile_shimmer.dart';
import 'list_tile_friend_component.dart';

class FriendsHomeComponent extends StatefulWidget {
  const FriendsHomeComponent({super.key});

  @override
  State<FriendsHomeComponent> createState() => _FriendsHomeComponentState();
}

class _FriendsHomeComponentState extends State<FriendsHomeComponent> {
  @override
  Widget build(BuildContext context) {
    //final friendsCubit = BlocProvider.of<FriendsCubit>(context);
    //final chatCubit = BlocProvider.of<ChatCubit>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Friends',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<GetMyFriendCubit, BaseFriendState>(
            builder: (context, state) {
          if (state is LoadingFriendState) {
            return Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const FriendTileShimmer();
                  }),
            );
          } else if (state is LoadedMyFriendsState) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.all(1.0.w),
                      child: ListTileFriendComponent(
                        index: index,
                        friends: state.data,
                        function: () {
                          // chatCubit
                          //     .showDialogsMethod(friendsCubit.myFriends[index]);
                          // chatCubit.getMessageBetweenUsers(
                          //     friendsCubit.myFriends[index].id);
                        },
                      ));
                },
              ),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const FriendTileShimmer();
                  }),
            );
          }
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Suggestion Friends',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<GetSuggestionFriendCubit, BaseFriendState>(
            builder: (context, state) {
          if (state is LoadingFriendState) {
            return Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const FriendTileShimmer();
                  }),
            );
          } else if (state is LoadedSuggestionFriendsState) {
            return Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(1.0.w),
                    child: ListTileFriendComponent(
                      index: index,
                      friends: state.data,
                      function: () {
                        // chatCubit.showDialogsMethod(
                        //     friendsCubit.suggestionFriends[index]);
                        // chatCubit.getMessageBetweenUsers(
                        //     friendsCubit.suggestionFriends[index].id);
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const FriendTileShimmer();
                  }),
            );
          }
        }),
      ],
    );
  }
}
