import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/core/constant.dart';
import 'package:moface/user/presentation/componenet/body_request.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_cubit.dart';

import '../../../core/global_resources/imagePathManager.dart';
import '../controller/friends_state/friends_state.dart';

class WaitingRequestFriend extends StatelessWidget {
  const WaitingRequestFriend({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitFriends = BlocProvider.of<FriendsCubit>(context);
    return Container(
        color: Colors.white,
        height: Constant.height(context) * .6,
        width: Constant.width(context) * .3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align the text to the start
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Waiting Requests",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocConsumer<FriendsCubit, BaseFriendsState>(
              listener: (context, state) {
                if (state is LoadedWaitingRequestFriends) {
                  cubitFriends.waitingRequestFriends = state.myFriends;
                }
              },
              builder: (context, state) {
                if (state is LoadingWaitingRequestFriends) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: Constant.height(context) * .5,
                  width: Constant.width(context) * .9,
                  // Increase width for better layout
                  child: ListView.builder(
                    itemCount: cubitFriends.waitingRequestFriends.length,
                    itemBuilder: (context, index) {
                      return BodyRequest(buttonText: "Accept request",friendData: cubitFriends
                          .waitingRequestFriends[index],onPressed: (){
                        BlocProvider.of<FriendsCubit>(context)
                            .acceptRequest(cubitFriends
                            .waitingRequestFriends[index].id);
                      },);
                    },
                  ),
                );
              },
            ),
          ],
        ));
  }
}
