import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moface/core/global_resources/color_manager.dart';
import 'package:sizer/sizer.dart';

class ButtonAuthontication extends StatelessWidget {
  const ButtonAuthontication(
      {super.key, required this.function, required this.title});

  final Function() function;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width * .2,
      height: 6.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: ColorManager.backGroundHomeColor,
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          // Make button background transparent
          shadowColor: Colors.transparent,
          // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), // Match the Container's borderRadius
          ),
        ),
        child: Text(
          title,
          style:  TextStyle(
            fontSize: 2.w,
              color: Colors.white, fontWeight: FontWeight.bold), // Text color
        ),
      ),
    );
  }
}
