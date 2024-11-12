import 'package:flutter/material.dart';
import 'package:mo_face_app/feature/auth_feature/domin/usecase/register_usecase.dart';
import 'package:mo_face_app/feature/auth_feature/presentation/controller/base_auth_cubit.dart';

import '../../../../core/dio_manager/dio_client.dart';
import '../../../../core/local_data_source/secure_local_data.dart';
import '../../../../core/user_data/user_data_provider.dart';
import '../../domin/entites/user_data_for_register.dart';
import 'base_auth_state.dart';

class RegisterCubit extends BaseAuthCubit {
  RegisterUseCase registerUseCase;

  RegisterCubit({required super.gwtUseCase,required this.registerUseCase});

  TextEditingController userName = TextEditingController();
  TextEditingController emailRegister = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void register() async {
    emit(LoadingState());
    final data = await registerUseCase.call(
      UserDataForRegister(
          email: emailRegister.text,
          password: passwordRegister.text,
          userName: userName.text,
          confirmPassword: confirmPassword.text),
    );
    data.fold((l) {
      emit(ErrorState(l.message));
    }, (r) async{
      passwordRegister.clear();
      emailRegister.clear();
      confirmPassword.clear();
      userName.clear();
      final token = await gwt(r.token);
      SecureStorageAuthHelper.saveUserData(
          isSignIn: 'true', userData: r, token: token);
      UserDataProvider().setUserData(r);
      await DioClient.instance.initialize();
      emit(LoadedState(r));
    });
  }

}