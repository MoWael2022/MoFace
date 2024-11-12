import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_recieve_request_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/manage_friend_cubit.dart';

import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/utilts/api_constant.dart';
import 'body_request.dart';

class WaitingRequestFriend extends StatelessWidget {
  const WaitingRequestFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<GetMyReceiveRequestCubit>()),
        BlocProvider(create: (context) => instance<ManageFriendCubit>()),
      ],
      child: Container(
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
              BlocBuilder<GetMyReceiveRequestCubit, BaseFriendState>(
                builder: (context, state) {
                  if (state is LoadingFriendState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is LoadedMyReceiveRequestState) {
                    return SizedBox(
                      height: Constant.height(context) * .5,
                      width: Constant.width(context) * .9,
                      // Increase width for better layout
                      child: ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return BlocBuilder<ManageFriendCubit,
                              BaseFriendState>(builder: (context, manageState) {
                            return BodyRequest(
                              buttonText: manageState is AcceptRequestState
                                  ? "you are friend now"
                                  : "Accept request",
                              friendData: state.data[index],
                              onPressed: () {
                                BlocProvider.of<ManageFriendCubit>(context)
                                    .acceptRequest(state.data[index].id);
                              },
                            );
                          });
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          )),
    );
  }
}
