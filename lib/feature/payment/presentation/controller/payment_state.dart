abstract class PaymentState {}

class InitState extends PaymentState {}

class LoadingState extends PaymentState {}

class LoadedState extends PaymentState {
  String token;

  LoadedState(this.token);
}

class ErrorState extends PaymentState {}
