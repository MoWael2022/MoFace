import 'package:bloc/bloc.dart';
import 'package:mo_face_app/core/user_data/user_data_provider.dart';
import 'package:mo_face_app/feature/splash/controller/data_state.dart';
import 'package:mo_face_app/core/local_data_source/secure_local_data.dart';
import 'package:mo_face_app/feature/auth_feature/domin/entites/user_data.dart';

import '../../../core/dio_manager/dio_client.dart';

class DataCubit extends Cubit<BaseDataState> {
  DataCubit() : super(InitState()){
    isSigIn();
  }

  void isSigIn() async {
    emit(LoadingIsSignInState());
    String isSignIn = await SecureStorageAuthHelper.isSignIn();
    if (isSignIn == "true") {
      getUserData();
      await UserDataProvider().initializeUserData();
      await DioClient.instance.initialize();
      emit(LoadedIsSignInState(true));
    } else {
      emit(LoadedIsSignInState(false));
    }
  }

  void getUserData() async {
    UserData userData = await SecureStorageAuthHelper.loadUserData();
    emit(LoadedUserDataState(userData));
  }
}
