import 'package:equatable/equatable.dart';
import 'package:moface/user/domin/entites/userData.dart';

class UserDataForLogin extends Equatable {
  final String email ;
  final String password ;

  const UserDataForLogin({required this.password ,required this.email});

  Map<String, String> toMap() {
    return {
      "Email": email,
      "Password": password,
    };
  }

  @override
  List<Object?> get props => [
    email,
    password,
  ];
}