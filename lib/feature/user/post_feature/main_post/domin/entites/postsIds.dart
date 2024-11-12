import 'package:equatable/equatable.dart';

class PostsIds extends Equatable {
  final List<dynamic> postsId;

  @override
  List<Object?> get props => [postsId];

  const PostsIds({required this.postsId});
}
