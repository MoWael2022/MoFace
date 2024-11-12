import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/core/component/main_appbar.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/base_auth_state.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/widgets/post.dart';
import 'package:mo_face_app/feature/user/post_feature/main_post/presentation/controller/main_post_cubit/get_home_post_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/service_locator/service_locator.dart';
import '../../../../payment/presentation/controller/paymnet_cubit.dart';
import '../../../../payment/presentation/widgets/payment_widget.dart';
import '../../../post_feature/main_post/domin/entites/get_post_data.dart';
import '../../../post_feature/main_post/presentation/controller/main_post_cubit/base_get_post_state.dart';
import '../../../post_feature/main_post/presentation/widgets/post_shimmer.dart';
import '../widgets/friends_home_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("build home screen");
    final getHomePostCubit = BlocProvider.of<GetHomePostCubit>(context);
    return MainAppbar(
      page: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(1.0.w),
            child: Container(
              width: 20.w, // Fixed width for Friends list
              color: Colors.grey[200],
              child: const FriendsHomeComponent(),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return  Dialog(
                        child: MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (context) => instance<PaymentCubit>()),
                            ], child: const PaymentScreen()),
                      );
                    });
              },
              child: Text("pay")),
          BlocConsumer<GetHomePostCubit, BaseGetPostState>(
              listener: (context, state) {
            if (getHomePostCubit.postIds.postsId.length <=
                getHomePostCubit.displayedHomePostData.length) {
              getHomePostCubit.inBatch = false;
            }
          }, builder: (context, state) {
            print("build bloc home screen");
            if (state is LoadingPostState) {
              return Expanded(
                child: ListView(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PostShimmer(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is ErrorOccurred) {
              return Center(
                child: Container(
                  width: 70.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(20),
                    border: const Border(
                      top: BorderSide(width: 7, color: Colors.grey),
                      // Top border
                      left: BorderSide(width: 7.0, color: Colors.grey),
                      // Left border
                      right: BorderSide(width: 7.0, color: Colors.grey),
                      // Right border
                      bottom: BorderSide(
                          width: 7.0, color: Colors.grey), // Bottom border
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          state.errorMessage,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView(
                controller: getHomePostCubit.homeScrollController,
                children: [
                  StreamBuilder<Set<GetPostData>>(
                    stream: getHomePostCubit.postsStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          width: 4.w,
                          child: const Column(
                            children: [
                              PostShimmer(),
                            ],
                          ),
                        );
                      }
                      final posts = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: posts.length +
                            (getHomePostCubit.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          print("build");
                          if (index == posts.length) {
                            // Show loading indicator at the end of the list
                            return const Center(child: PostShimmer());
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Post(
                                post: posts.elementAt(index),
                                posts: posts.toList(),
                                index: index,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  if (getHomePostCubit.inBatch)
                    SizedBox(
                      width: 4.w,
                      child: const Column(
                        children: [
                          PostShimmer(),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
