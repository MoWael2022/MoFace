import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/login_cubit.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/register_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/color_manager.dart';
import '../widgets/SignUp.dart';
import '../widgets/login.dart';
import '../widgets/swap_widget_authontication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AlignmentGeometry alignmentGeometry = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    final navigation = Navigator.of(context);
    //final chatCubit = BlocProvider.of<ChatCubit>(context);
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: ColorManager.backGroundHomeColor,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * .1,
                left: MediaQuery.of(context).size.width * .1),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .75,
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.loginAndRegister.withOpacity(.5),
                    ),
                    color: ColorManager.loginAndRegister.withOpacity(.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SignUp(
                          function: () {
                            registerCubit.passwordRegister.clear();
                            registerCubit.emailRegister.clear();
                            registerCubit.confirmPassword.clear();
                            registerCubit.userName.clear();
                            setState(() {
                              alignmentGeometry = Alignment.centerLeft;
                            });
                          },
                        ),
                        Login(
                          function: () {
                            loginCubit.passwordLogin.clear();
                            loginCubit.emailLogin.clear();
                            setState(() {
                              alignmentGeometry = Alignment.centerRight;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedAlign(
                    duration: const Duration(milliseconds: 500),
                    alignment: alignmentGeometry,
                    curve: Curves.easeInOutBack,
                    child: const SwapWidgetAuthontication())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
