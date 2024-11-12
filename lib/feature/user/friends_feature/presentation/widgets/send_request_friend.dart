import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/get_my_send_request_cubit.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/manage_friend_cubit.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/utilts/api_constant.dart';
import 'body_request.dart';

class SendRequestFriend extends StatelessWidget {
  const SendRequestFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<GetMySendRequestCubit>()),
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
                  "Send Request",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BlocBuilder<GetMySendRequestCubit, BaseFriendState>(
                builder: (context, state) {
                  if (state is LoadingFriendState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LoadedMySendRequestsState) {
                    return SizedBox(
                      height: Constant.height(context) * .5,
                      width: Constant.width(context) * .9,
                      // Increase width for better layout
                      child: ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return BlocConsumer<
                              ManageFriendCubit,
                              BaseFriendState>(
                              listener: (context, manageState) {
                                if (manageState is CancelRequestState) {

                                }
                              },
                              builder: (context, manageState) {
                                return BodyRequest(
                                  buttonText: manageState is CancelRequestState ? "request Canceled" : "Cancel request",
                                  friendData: state.data[index],
                                  onPressed: () {
                                    BlocProvider.of<ManageFriendCubit>(context)
                                        .cancelRequest(state.data[index].id);
                                  },
                                );
                              }
                          );
                        },
                      ),
                    );
                  } else if (state is ErrorOccurred) {
                    return Column(
                      children: [
                        Text(state.message),
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).pushNamed(
                              Routers.suggestionFriends);
                        }, child: const Text("Suggestion Friend")),
                      ],
                    );
                  }
                  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          )),
    );
  }
}
