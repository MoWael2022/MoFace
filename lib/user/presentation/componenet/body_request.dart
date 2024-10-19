import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moface/user/domin/entites/friends/friend_data.dart';

import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';

class BodyRequest extends StatelessWidget {
  BodyRequest({super.key,required this.friendData,required this.onPressed ,required this.buttonText});

  FriendData friendData;
  VoidCallback onPressed;
  String buttonText ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Constant.height(context) * .01),
      padding: EdgeInsets.all(Constant.width(context) * .02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Constant.height(context) * .05,
            backgroundColor: Colors.grey[300],
            // Slightly darker background
            child: CircleAvatar(
              radius: Constant.height(context) * .04,
              backgroundImage: friendData
                  .profileImg
                  .isEmpty
                  ? const NetworkImage(
                  ImagePathManager.defaultProfileImage)
                  : MemoryImage(base64Decode(friendData
                  .profileImg)) as ImageProvider,
            ),
          ),
          SizedBox(width: Constant.width(context) * .05),
          // Spacer between avatar and text
          Expanded(
            // Expanded for better text fit
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friendData.username,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height: Constant.height(context) * .01),
                // Spacer between text and button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    // Change button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: onPressed,
                  child:  Text(
                    buttonText,
                    style:const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
