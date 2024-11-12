import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String userName;
  final String profileimg;

  const User({
    required this.id,
    required this.userName,
    required this.profileimg,
  });


  @override
  List<Object?> get props => [
    id,
    userName,
    profileimg,
  ];
}