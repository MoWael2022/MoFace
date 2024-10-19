import 'package:equatable/equatable.dart';

class FriendData extends Equatable {
  final String id;

  final String username;
  final String profileImg;

  const FriendData(
      {required this.username, required this.id, required this.profileImg});

  @override
  List<Object?> get props => [
        id,
        username,
        profileImg,
      ];
}
