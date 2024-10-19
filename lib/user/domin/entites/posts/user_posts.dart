import 'package:equatable/equatable.dart';

class UserPosts extends Equatable {
  final List<dynamic> postsId;

  @override
  List<Object?> get props => [postsId];

  const UserPosts({required this.postsId});
}
