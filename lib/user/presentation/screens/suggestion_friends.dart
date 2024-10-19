import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_cubit.dart';
import 'package:moface/user/presentation/controller/loading_cubit/data_state.dart';

import '../../../core/constant.dart';
import '../componenet/AddFriends_componenet.dart';
import '../controller/friends_state/friends_state.dart';

class SuggestionFriendsScreen extends StatelessWidget {
  const SuggestionFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsCubit = BlocProvider.of<FriendsCubit>(context);
    return Scaffold(
      body: BlocConsumer<FriendsCubit, BaseFriendsState>(
        listener: (context ,state) {
          if(state is LoadedSuggestionFriends){
            friendsCubit.suggestionFriends =state.suggestionFriends;
          }
        },
          builder: (context, state) {
            if (state is LoadingSuggestionFriends) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Container(
                color:Colors.grey[200],
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Minimize the space the column occupies
                  children: [
                    const Text('Suggestion Friends', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: Constant.width(context) * .5,
                      height: Constant.height(context)*.9,
                      child: ListView.builder(
                        itemCount: friendsCubit.suggestionFriends.length,
                        itemBuilder: (context, index) {
                          print(friendsCubit.suggestionFriends[index]);
                          return AddFriendsComponent(
                            friendData: friendsCubit.suggestionFriends[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

