import 'package:equatable/equatable.dart';

class FriendsDataEnter extends Equatable {
  final String token;

  final String userId;

  const FriendsDataEnter({required this.userId, required this.token});

  @override

  List<Object?> get props => [
        token,
        userId,
      ];
}
