import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/core/component/main_appbar.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_suggestion_friend_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utilts/api_constant.dart';
import '../controller/base_friend_state.dart';
import '../widgets/AddFriends_componenet.dart';

class SuggestionFriendsScreen extends StatelessWidget {
  const SuggestionFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAppbar(
      page: BlocConsumer<GetSuggestionFriendCubit, BaseFriendState>(
          listener: (context, state) {
        // if(state is LoadedSuggestionFriends){
        //   friendsCubit.suggestionFriends =state.suggestionFriends;
        // }
      }, builder: (context, state) {
        if (state is LoadingFriendState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoadedSuggestionFriendsState) {
          return Center(
            child: Container(
              width: 50.w,
              color: Colors.grey[200],
              child: ListView(
                //mainAxisSize: MainAxisSize.min,
                // Minimize the space the column occupies
                children: [
                  const Text('Suggestion Friends',
                      style: TextStyle(fontSize: 20)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return AddFriendsComponent(
                        friendData: state.data[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
