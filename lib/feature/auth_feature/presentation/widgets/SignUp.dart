import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/base_auth_state.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/register_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/color_manager.dart';
import '../../../../core/router/router.dart';
import '../../../../generated/l10n.dart';
import 'button_authontication.dart';
import 'custom_text_form_field.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key, required this.function});

  Function() function;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RegisterCubit>(context);
    final navigation = Navigator.of(context);
    return BlocListener<RegisterCubit, BaseAuthState>(
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.pop(context);
          navigation.pushReplacementNamed(Routers.home);
        } else if (state is LoadingState) {
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
                S.of(context).signUp,
                style: TextStyle(
                    fontSize: 4.w,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: ColorManager.loginAndRegisterTextColor),
              ),
            ),
            CustomTextFormField(
                hintText: S.of(context).userName,
                icons: Icons.person,
                obscureText: false,
                textEditingController: cubit.userName,
                validator: (validate) {
                  if (validate == "") {
                    return S.of(context).usernameMessageError;
                  }
                  return null;
                }),
            CustomTextFormField(
                hintText: S.of(context).email,
                icons: Icons.email_outlined,
                obscureText: false,
                textEditingController: cubit.emailRegister,
                validator: (validate) {
                  final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (validate == "") {
                    return S.of(context).emailMessageError;
                  } else if (!emailRegExp.hasMatch(validate!)) {
                    return S.of(context).emailMessageError2;
                  }
                  return null;
                }),
            CustomTextFormField(
                hintText: S.of(context).Password,
                icons: Icons.lock,
                obscureText: false,
                textEditingController: cubit.passwordRegister,
                validator: (validate) {
                  final passwordRegExp = RegExp(
                      r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                  if (validate == "") {
                    return S.of(context).passwordMessageError;
                  } else if (!passwordRegExp.hasMatch(validate!)) {
                    return S.of(context).passwordMessageError2;
                  }
                  return null;
                }),
            CustomTextFormField(
                hintText: S.of(context).ConfirmPassword,
                icons: Icons.lock,
                obscureText: false,
                textEditingController: cubit.confirmPassword,
                validator: (validate) {
                  if (validate == "") {
                    return S.of(context).cPasswordMessageError;
                  } else if (validate != cubit.passwordRegister.text) {
                    return S.of(context).cPasswordMessageError2;
                  }
                  return null;
                }),
            Padding(
              padding: EdgeInsets.all(1.w),
              child: ButtonAuthontication(
                title: S.of(context).signUp,
                function: () {
                  if (formKey.currentState!.validate()) {
                    cubit.register();
                  }
                },
              ),
            ),
            TextButton(
              onPressed: function,
              child: Text(
                S.of(context).haveAccount,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 1.w,
                    color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
