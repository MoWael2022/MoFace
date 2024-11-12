import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/core/service_locator/service_locator.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/base_get_post_state.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/get_profile_post_cubit.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/utilts/functions.dart';
import '../../../friends_feature/domin/entites/friend_data.dart';

class ListTileFriendComponent extends StatelessWidget {
  const ListTileFriendComponent(
      {super.key,
      required this.friends,
      required this.index,
      required this.function});

  final List<FriendData> friends;
  final int index;

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    //final getProfileDataCubit = BlocProvider.of<GetProfilePostCubit>(context);
    return BlocProvider(
      create: (context)=>instance<GetProfilePostCubit>(),
      child: BlocListener<GetProfilePostCubit,BaseGetPostState>(
        listener: (context ,state ){
          if(state is LoadedInitPost){
            //Navigator.of(context).pushNamed(Routers.userprofile);
          }
        },
        child: ListTile(
          leading: GestureDetector(
            onTap: () async{
              // BlocProvider.of<GetProfilePostCubit>(context).currentUser = friends[index];
              // print('.........................................');
              // print(BlocProvider.of<GetProfilePostCubit>(context).currentUser);
              // print('.........................................');
              // await BlocProvider.of<GetProfilePostCubit>(context).getProfilePostPost();
            },
            child: CircleAvatar(
              backgroundImage: Functions.getUserImage(friends[index].profileImg),
            ),
          ),
          title: Text(friends[index].username),
          trailing: IconButton(
            icon: const Icon(Icons.chat_outlined),
            onPressed: function,
          ),
        ),
      ),
    );
  }
}
