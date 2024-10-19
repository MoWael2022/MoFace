import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/core/constant.dart';
import 'package:moface/user/presentation/componenet/body_request.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_cubit.dart';

import '../../../core/global_resources/imagePathManager.dart';
import '../controller/friends_state/friends_state.dart';

class SendRequestFriend extends StatelessWidget {
  const SendRequestFriend({super.key});

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
                "Send Request",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocConsumer<FriendsCubit, BaseFriendsState>(
              listener: (context, state) {
                if (state is LoadedSendRequestFriends) {
                  cubitFriends.sendRequestFriends = state.myFriends;
                } else if (state is CancelRequestState) {
                  cubitFriends.sendRequestFriends
                      .removeWhere((element) => element.id == state.id);
                }
              },
              builder: (context, state) {
                if (state is LoadingSendRequestFriends ||
                    state is LoadingSuggestionFriends) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: Constant.height(context) * .5,
                  width: Constant.width(context) * .9,
                  // Increase width for better layout
                  child: ListView.builder(
                    itemCount: cubitFriends.sendRequestFriends.length,
                    itemBuilder: (context, index) {
                      return BodyRequest(buttonText: "Cancel request",friendData: cubitFriends
                          .sendRequestFriends[index],onPressed: (){
                        BlocProvider.of<FriendsCubit>(context)
                            .cancelRequest(cubitFriends
                            .sendRequestFriends[index].id);
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
