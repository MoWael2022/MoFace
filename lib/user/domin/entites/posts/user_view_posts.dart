import 'package:equatable/equatable.dart';

class UserPostDataEnter extends Equatable {
  final String token;

  final String userId;

  const UserPostDataEnter({required this.token, required this.userId});

  Map<String, String> toMap() {
    return {"userId": userId};
  }

  @override
  List<Object?> get props => [
        token,
        userId,
      ];
}
