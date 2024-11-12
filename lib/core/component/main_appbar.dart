import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/core/user_data/user_data_provider.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_recieve_requests_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_recieve_request_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_send_request_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../feature/user/friends_feature/presentation/controller/base_friend_state.dart';
import '../../feature/user/friends_feature/presentation/widgets/send_request_friend.dart';
import '../../feature/user/friends_feature/presentation/widgets/waiting_request_friends.dart';
import '../../feature/user/post_feature/main_post/presentation/widgets/user_image.dart';
import '../service_locator/service_locator.dart';
import '../utilts/api_constant.dart';
import '../utilts/functions.dart';
import 'icon_component.dart';

class MainAppbar extends StatelessWidget {
  MainAppbar({super.key, required this.page});

  final userData = UserDataProvider().userData;
  Widget page;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<GetMySendRequestCubit>()),
        BlocProvider(create: (context) => instance<GetMyReceiveRequestCubit>())
      ],
      child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            leadingWidth: width * .2,
            actions: [
              Container(
                width: width * .2,
                padding: EdgeInsets.only(left: width * .02, right: width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(userData!.name),
                    UserImage(
                      image: userData!.photoImage,
                    ),
                  ],
                ),
              ),
            ],
            centerTitle: true,
            title: SizedBox(
              width: width * .5,
              child: Container(),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: width * .02, right: width * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      foregroundImage:
                          Functions.getUserImage(userData!.photoImage),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
                            child: BlocConsumer<GetMyReceiveRequestCubit,
                                    BaseFriendState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return Center(
                                    child: Text(
                                      (state is LoadedMyReceiveRequestState)
                                          ? state.data.length.toString()
                                          : "0",
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconComponent(
                    icon: Icons.send_and_archive_sharp,
                    onPressed: () {
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
          body: page
          // const TabBarView(
          //   children: [
          //     HomeScreen(),
          //     ProfileScreen(),
          //   ],
          // ),
          ),
    );
  }
}
