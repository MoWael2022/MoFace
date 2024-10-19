import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:moface/core/service_locator.dart';
import 'package:moface/user/domin/entites/userData.dart';
import 'package:moface/user/domin/entites/user_data_for_login.dart';
import 'package:moface/user/domin/entites/user_data_for_register.dart';
import 'package:moface/user/domin/usecase/login_usecase.dart';
import 'package:moface/user/domin/usecase/refresh_token_usecase.dart';
import 'package:moface/user/domin/usecase/register_usecase.dart';
import 'package:moface/user/presentation/controller/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitState());

  TextEditingController emailLogin = TextEditingController();

  TextEditingController passwordLogin = TextEditingController();

  TextEditingController userName = TextEditingController();
  TextEditingController emailRegister = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void login() async {
    emit(LoadingState());
    final result = instance<LoginUseCase>();
    final data = await result.call(
      UserDataForLogin(email: emailLogin.text, password: passwordLogin.text),
    );
    data.fold((l) {
      emit(ErrorState(l.messageError));
    }, (r) {
      emit(LoadedState(r));
      passwordLogin.clear();
      emailLogin.clear();
    });
  }

  Future<String> GWT(String token) async {
    final result = instance<GWTUseCase>();
    final data = await result.call(token);
    String decryptToken = '';
    data.fold((l) {}, (r) {
      decryptToken = r;
    });
    return decryptToken;
  }

  void register() async {
    emit(LoadingState());
    final result = instance<RegisterUseCase>();
    final data = await result.call(
      UserDataForRegister(
          email: emailRegister.text,
          password: passwordRegister.text,
          userName: userName.text,
          confirmPassword: confirmPassword.text),
    );
    data.fold((l) {
      emit(ErrorState(l.messageError));
    }, (r) {
      emit(LoadedState(r));
      passwordRegister.clear();
      emailRegister.clear();
      confirmPassword.clear();
      userName.clear();
    });
  }
}
