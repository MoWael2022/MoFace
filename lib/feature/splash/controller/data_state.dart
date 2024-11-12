import 'package:mo_face_app/feature/auth_feature/domin/entites/user_data.dart';

abstract class BaseDataState {}

class InitState extends BaseDataState {}

class LoadingIsSignInState extends BaseDataState {}

class LoadedIsSignInState extends BaseDataState {
  bool isSignIn;

  LoadedIsSignInState(this.isSignIn);
}

class ErrorIsSignInstate extends BaseDataState {
  String messageError;

  ErrorIsSignInstate(this.messageError);
}

class LoadingUserDataState extends BaseDataState {}

class LoadedUserDataState extends BaseDataState {
  UserData userData;

  LoadedUserDataState(this.userData);
}

class ErrorUserDataState extends BaseDataState {
  String messageError;

  ErrorUserDataState(this.messageError);
}
