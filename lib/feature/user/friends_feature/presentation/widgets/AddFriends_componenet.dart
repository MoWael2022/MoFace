import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/manage_friend_cubit.dart';

import '../../../../../core/utilts/api_constant.dart';
import '../../../../../core/utilts/functions.dart';
import '../../domin/entites/friend_data.dart';

class AddFriendsComponent extends StatelessWidget {
  const AddFriendsComponent({super.key, required this.friendData});

  final FriendData friendData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constant.width(context) * .02),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(10), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(Constant.width(context) * .02),
          // Add padding inside the container
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: Constant.width(context) * .04, // Increase size a bit
                child: CircleAvatar(
                  radius: Constant.width(context) * .035,
                  backgroundImage:
                      Functions.getUserImage(friendData.profileImg),
                ),
              ),
              SizedBox(width: Constant.width(context) * .05),
              // Spacer between avatar and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align text to the start
                children: [
                  Text(
                    friendData.username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Constant.height(context) * .01),
                  // Spacer between text and button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Round button edges
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Constant.width(context) * .04,
                        vertical: Constant.height(context) * .01,
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<ManageFriendCubit>(context)
                          .sendRequest(friendData.id);
                      // Add your friend request logic here
                    },
                    child: BlocBuilder<ManageFriendCubit, BaseFriendState>(
                        builder: (context, state) {
                      if (state is SendRequestState &&
                          state.friendId == friendData.id) {
                        return const Text('Request Sent');
                      } else {
                        return const Text('Add Friend');
                      }
                    }),
                  ),
                ],
              ),
              const Spacer(),
              // Push button and text to the left
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Add functionality for more options if needed
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
