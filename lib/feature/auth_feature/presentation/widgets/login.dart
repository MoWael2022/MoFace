import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/base_auth_state.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/login_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/color_manager.dart';
import '../../../../core/router/router.dart';
import '../../../../generated/l10n.dart';
import 'button_authontication.dart';
import 'custom_text_form_field.dart';

class Login extends StatefulWidget {
  Login({super.key, required this.function});

  Function() function;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final navigation = Navigator.of(context);
    final cubit = BlocProvider.of<LoginCubit>(context);
    return BlocListener<LoginCubit, BaseAuthState>(
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.pop(context);
          navigation.pushReplacementNamed(Routers.home);
        }else if(state is LoadingState){
          showDialog(
            context: context,
            barrierDismissible: false, // Prevent dismissing the dialog
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Center(
              child: Text(
                S.of(context).login,
                style: TextStyle(
                    fontSize: 4.w,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: ColorManager.loginAndRegisterTextColor),
              ),
            ),
            CustomTextFormField(
                hintText: S.of(context).email,
                icons: Icons.email_outlined,
                obscureText: false,
                textEditingController: cubit.emailLogin,
                validator: (validate) {
                  if (validate == "") {
                    return S.of(context).emailMessageError;
                  }
                  return null;
                }),
            CustomTextFormField(
                hintText: S.of(context).Password,
                icons: Icons.lock,
                obscureText: false,
                textEditingController: cubit.passwordLogin,
                validator: (validate) {
                  if (validate == "") {
                    return S.of(context).passwordMessageError;
                  }
                  return null;
                }),
            Padding(
              padding: EdgeInsets.all(1.w),
              child: ButtonAuthontication(
                title: S.of(context).login,
                function: () async{
                  if (formKey.currentState!.validate()) {
                    await cubit.login();
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: widget.function,
                  child: Text(
                    S.of(context).CreateAnAccount,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 1.w,
                        color: Colors.black87),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    S.of(context).forgetPassword,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 1.w,
                        color: Colors.black87),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
