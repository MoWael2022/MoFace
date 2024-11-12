import 'package:equatable/equatable.dart';

class UserDataForRegister extends Equatable {
  final String userName;

  final String email;

  final String password;

  final String confirmPassword;

  const UserDataForRegister(
      {required this.userName,
      required this.email,
      required this.password,
      required this.confirmPassword});

  Map<String, String> toMap() {
    return {
      "Email": email,
      "Username": userName,
      "Password": password,
      "ConfirmPassword": confirmPassword,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userName, email, password, confirmPassword];
}
