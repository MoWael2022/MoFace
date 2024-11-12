import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  final int? code;

  final int? statusCode;

  const Failure({required this.message, this.code, this.statusCode});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = "Server failure",super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = "Authentication failure"});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = "Network connection failure"});
}
