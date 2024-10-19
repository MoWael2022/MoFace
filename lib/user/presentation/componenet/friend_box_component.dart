import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_state.dart';

import '../../../core/constant.dart';
import '../../../core/router.dart';
import '../../domin/entites/friends/friend_data.dart';
import '../controller/friends_state/friends_cubit.dart';
import '../controller/loading_cubit/data_cubit.dart';

class FriendBoxComponent extends StatefulWidget {
  //final List<Map<String, String>> friends;

  const FriendBoxComponent({
    super.key,
  });

  @override
  State<FriendBoxComponent> createState() => _FriendBoxComponentState();
}

class _FriendBoxComponentState extends State<FriendBoxComponent> {
  getMyFriends ()async{
    await BlocProvider.of<FriendsCubit>(context).getMyFriends();
  }
  @override
  void initState() {
    super.initState();
    getMyFriends();
  }

  @override
  Widget build(BuildContext context) {
    final friendsCubit = BlocProvider.of<FriendsCubit>(context);
    final dataCubit = BlocProvider.of<DataCubit>(context);
    return BlocConsumer<FriendsCubit,BaseFriendsState>(
      listener:(context,state){
        print(state);
        if(state is LoadedSuggestionFriends){
          friendsCubit.suggestionFriends =state.suggestionFriends;
        }
        if (state is LoadMyFriends){
          friendsCubit.myFriends = state.myFriends;
        }
      },
      builder: (context,state) {
        //print(friendsCubit.myFriends);
        // if(state is LoadingMyFriends){
        //   return const Center(child: CircularProgressIndicator(),);
        // }
        return Container(
          width: Constant.width(context) * .3 , // Adjusted width
          padding: const EdgeInsets.all(16), // Padding inside the container
          decoration: BoxDecoration(
            color: Colors.grey[100], // Light grey background color
            borderRadius: BorderRadius.circular(16), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: friendsCubit.myFriends.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "No Friends",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routers.suggestionFriends);
                  friendsCubit.getSuggestionFriends();
                  dataCubit.showSuggestionsScreen =true;
                  //print(dataCubit.showSuggestionsScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded button
                  ),
                ),
                child: const Text("Suggest Friends"),
              ),
            ],
          )
              : Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Display 3 friends per row
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: friendsCubit.myFriends.length > 6 ? 6 : friendsCubit.myFriends.length,
                itemBuilder: (context, index) {
                  return _friendItem(friendsCubit.myFriends[index]);
                },
              ),
              const SizedBox(height: 16),
              if (friendsCubit.myFriends.length > 6)
                ElevatedButton(
                  onPressed: () {
                    // Show all friends
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded button
                    ),
                  ),
                  child: const Text("Show All Friends"),
                ),
            ],
          ),
        );
      }
    );
  }

  // Friend item widget displaying image and name
  Widget _friendItem(FriendData friends) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: MemoryImage(base64Decode(friends.profileImg ?? '')),
        ),
        const SizedBox(height: 8),
        Text(
          friends.username?? '',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
