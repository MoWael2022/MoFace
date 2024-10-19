import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/color_manager.dart';
import '../../../generated/l10n.dart';
import '../controller/auth_cubit/auth_cubit.dart';
import '../componenet/button_authontication.dart';
import '../componenet/custom_text_form_field.dart';

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
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Form(
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
              function: () {
                if (formKey.currentState!.validate()) {
                  cubit.login();
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
    );
  }
}
