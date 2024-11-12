import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/splash/controller/data_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../core/component/color_manager.dart';
import '../../../core/component/imagePathManager.dart';
import '../../../core/router/router.dart';
import '../controller/data_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<AlignmentGeometry> _alignment =
      ValueNotifier(const Alignment(0, -20));

  _navigateFromSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSignIn = prefs.getBool("isSignIn");
    String? id = prefs.getString("id");
    if ((isSignIn == null || !isSignIn)) {
      Timer(const Duration(seconds: 10), () {
        Navigator.of(context).pushNamed(Routers.login);
        //BlocProvider.of<ChatCubit>(context).connect(id!);
      });
    } else {
      Timer(const Duration(seconds: 10), () {
        Navigator.of(context).pushNamed(Routers.home);
      });
    }
  }

  @override
  void initState() {
    //_navigateFromSplash();
    Future.delayed(const Duration(milliseconds: 500), () {
      _alignment.value = Alignment.center; // Animate to center after delay
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DataCubit, BaseDataState>(listener: (context, state) {
        if (state is LoadedIsSignInState) {
          if(!state.isSignIn){
            Timer(const Duration(seconds: 4), () {
              Navigator.of(context).pushNamed(Routers.login);
            });
          }else {
            Timer(const Duration(seconds: 4), () {
              Navigator.of(context).pushNamed(Routers.home);
            });
          }
        }
        if (state is LoadedUserDataState) {
          //BlocProvider.of<DataCubit>(context).currentUserData = state.userData;
        }
      }, builder: (context, state) {
          return Container(
            width: double.infinity,
            height: 100.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: ColorManager.backGroundHomeColor,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
            child: ValueListenableBuilder(
                valueListenable: _alignment,
                builder: (context, value, child) {
                  return AnimatedAlign(
                    curve: Curves.bounceOut,
                    duration: const Duration(seconds: 3),
                    alignment: value, // Apply alignment here
                    child: SizedBox(
                      height: 50.h,
                      width: 50.h,
                      child: const Image(
                        image: AssetImage(ImagePathManager.logo),
                      ),
                    ),
                  );
                }),
          );
        }
      ),
    );
  }
}
