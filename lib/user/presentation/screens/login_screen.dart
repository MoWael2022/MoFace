import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/core/global_resources/color_manager.dart';
import 'package:moface/core/global_resources/functions.dart';
import 'package:moface/user/presentation/componenet/button_authontication.dart';
import 'package:moface/user/presentation/componenet/custom_text_form_field.dart';
import 'package:moface/user/presentation/screens/SignUp.dart';
import 'package:moface/user/presentation/screens/login.dart';
import 'package:moface/user/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../../../generated/l10n.dart';
import '../componenet/swap_widget_authontication.dart';
import '../controller/auth_cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AlignmentGeometry alignmentGeometry = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is LoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false, // Prevent dismissing the dialog
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (state is LoadedState) {
            SharedPreferences sharedpref =
                await SharedPreferences.getInstance();
            final token = await cubit.GWT(state.userData.token);

            sharedpref.setString('token', token);
            sharedpref.setString('username', state.userData.name);
            sharedpref.setString('photoImg', state.userData.photoImage);
            sharedpref.setString('id', state.userData.id);
            sharedpref.setString(
                'backgroundImg', state.userData.backgroundImgge);
            // sharedpref.setStringList(
            //     'rules', state.userData.rules as List<String>);
            sharedpref.setString('email', state.userData.email);
            sharedpref.setBool('isSignIn', true);
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed(Routers.main);
          } else if (state is ErrorState) {
            Navigator.pop(context);
            Dialogs.errorAwesomeDialog(
              context,
              state.messageError,
            );
            // showDialog(
            //   context: context,
            //   barrierDismissible: false, // Prevent dismissing the dialog
            //   builder: (BuildContext context) {
            //     return Center(
            //       child: Container(
            //           color: Colors.white, child: Text(state.messageError.toString())),
            //     );
            //   },
            // );
          }
        },
        child: Container(
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
                              cubit.passwordRegister.clear();
                              cubit.emailRegister.clear();
                              cubit.confirmPassword.clear();
                              cubit.userName.clear();
                              setState(() {
                                alignmentGeometry = Alignment.centerLeft;
                              });
                            },
                          ),
                          Login(
                            function: () {
                              cubit.passwordLogin.clear();
                              cubit.emailLogin.clear();
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
      ),
    );
  }
}
