import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/color_manager.dart';
import '../../../core/global_resources/imagePathManager.dart';

class SwapWidgetAuthontication extends StatelessWidget {
  const SwapWidgetAuthontication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      height: MediaQuery.of(context).size.height * .85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          colors: ColorManager.backGroundHomeColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            spreadRadius: 5, // How much the shadow spreads
            blurRadius: 10, // How much the shadow blurs
            offset: const Offset(0, 5), // Offset of the shadow (x, y)
          ),
        ],
      ),
      child:  Center(
        child: Image.asset(ImagePathManager.logo),
      ),
    );
  }
}
