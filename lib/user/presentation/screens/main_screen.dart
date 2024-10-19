import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/presentation/componenet/waiting_request_friends.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_cubit.dart';
import 'package:moface/user/presentation/controller/app_cubit/app_state.dart';
import 'package:moface/user/presentation/controller/chat_cubit/chat_cubit.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_cubit.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_state.dart';
import 'package:moface/user/presentation/controller/loading_cubit/data_cubit.dart';
import 'package:moface/user/presentation/screens/chat_screen.dart';
import 'package:moface/user/presentation/screens/home.dart';
import 'package:moface/user/presentation/screens/profile_screen.dart';

import '../../../core/constant.dart';
import '../../../core/global_resources/imagePathManager.dart';
import '../componenet/icon_component.dart';
import '../componenet/send_request_friend.dart';
import '../controller/loading_cubit/data_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = BlocProvider.of<DataCubit>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<DataCubit, DataState>(builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            leadingWidth: width * .2,
            actions: [
              Container(
                width: width * .2,
                padding: EdgeInsets.only(left: width * .02, right: width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconComponent(
                      icon: Icons.notifications,
                      onPressed: () {

                      },
                    ),
                    IconComponent(
                      icon: Icons.chat,
                      onPressed: () {

                        //BlocProvider.of<ChatCubit>(context).saveConnection(userData.userData!.id);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ],
            centerTitle: true,
            title: SizedBox(
              width: width * .5,
              child: const TabBar(
                isScrollable: false,
                dividerHeight: 0,
                tabs: [
                  Tab(
                    child: Text("home"),
                  ),
                  Tab(
                    child: Text("profile"),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: width * .02, right: width * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      foregroundImage: userData.userData!.photoImage.isEmpty ||
                              userData.userData!.photoImage == "ChQeKDI="
                          ? const NetworkImage(
                              ImagePathManager.defaultProfileImage)
                          : MemoryImage(
                              base64Decode(userData.userData!.photoImage)),
                    ),
                  ),
                  BlocConsumer<FriendsCubit, BaseFriendsState>(
                      listener: (context, state) {
                    if (state is LoadedWaitingRequestFriends) {
                      BlocProvider.of<FriendsCubit>(context)
                          .waitingRequestFriends = state.myFriends;
                    }
                  }, builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<FriendsCubit>(context)
                            .getWaitingRequestFriends();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Dialog(
                                child: WaitingRequestFriend(),
                              );
                            });
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.notifications),
                          ),
                          Positioned(
                            right: 1,
                            top: -5,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: Constant.width(context) * .0055,
                              child: Center(
                                  child: Text(
                                      BlocProvider.of<FriendsCubit>(context)
                                          .waitingRequestFriends
                                          .length
                                          .toString())),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  IconComponent(
                    icon: Icons.send_and_archive_sharp,
                    onPressed: () {
                      BlocProvider.of<FriendsCubit>(context)
                          .getSendRequestFriends();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Dialog(
                              child: SendRequestFriend(),
                            );
                          });
                    },
                  ),
                  IconComponent(
                    icon: Icons.chat,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              HomeScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      );
    });
  }
}
