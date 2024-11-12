import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';
import 'package:sizer/sizer.dart';


class FriendTileShimmer extends StatelessWidget {
  const FriendTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    //final loadPostCubit = BlocProvider.of<LoadPostCubit>(context);
    return Padding(
      padding: EdgeInsets.all(1.0.w),
      child: Container(
          child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
        ),
        title: const Text("none"),
        trailing: Container(
          width: 2.w,
          height: 2.w,
          color: Colors.black,
          child: Icon(
            Icons.chat_outlined,
          ),
        ).redacted(
            context: context,
            redact: true,
            configuration: RedactedConfiguration(
                animationDuration: const Duration(milliseconds: 800))),
      )).redacted(
          context: context,
          redact: true,
          configuration: RedactedConfiguration(
              animationDuration: const Duration(milliseconds: 800))),
    );
  }
}
