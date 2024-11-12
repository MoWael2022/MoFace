import '../../domin/entites/user_data.dart';

abstract class BaseAuthState {}

class InitState extends BaseAuthState {}

class LoadingState extends BaseAuthState {}

class LoadedState extends BaseAuthState {
  UserData userData;

  LoadedState(this.userData);
}

class ErrorState extends BaseAuthState {
  String messageError;

  ErrorState(this.messageError);
}
