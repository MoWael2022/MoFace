import 'package:flutter/material.dart';
import 'package:mo_face_app/feature/auth_feature/domin/usecase/login_usecase.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/base_auth_cubit.dart';

import '../../../../core/dio_manager/dio_client.dart';
import '../../../../core/local_data_source/secure_local_data.dart';
import '../../../../core/user_data/user_data_provider.dart';
import '../../domin/entites/user_data_for_login.dart';
import 'base_auth_state.dart';

class LoginCubit extends BaseAuthCubit {
  LoginUseCase loginUseCase;

  TextEditingController emailLogin = TextEditingController();

  TextEditingController passwordLogin = TextEditingController();

  LoginCubit({required super.gwtUseCase, required this.loginUseCase});

  login() async {
    emit(LoadingState());
    final data = await loginUseCase.call(
      UserDataForLogin(email: emailLogin.text, password: passwordLogin.text),
    );
    data.fold((l) {
      emit(ErrorState(l.message));
    }, (r) async {
      passwordLogin.clear();
      emailLogin.clear();
      final token = await gwt(r.token);
      await SecureStorageAuthHelper.saveUserData(
          isSignIn: 'true', userData: r, token: token);
      UserDataProvider().setUserData(r);
      await DioClient.instance.initialize();
      emit(LoadedState(r));
    });
  }
}
