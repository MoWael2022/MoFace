import '../../../domin/entites/userData.dart';

abstract class AuthState {}

class InitState extends AuthState {}

class LoadingState extends AuthState {}

class LoadedState extends AuthState {
  UserData userData;

  LoadedState(this.userData);
}

class ErrorState extends AuthState {
  String messageError;

  ErrorState(this.messageError);
}
