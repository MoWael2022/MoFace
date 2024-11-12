import 'package:equatable/equatable.dart';

class DataForDeletePost extends Equatable {
  final String userId;

  final int postId;

  Map<String, dynamic> toMap() {
    return {
      "iduser": userId,
      "idpost": postId,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        postId,
      ];

  const DataForDeletePost({
    required this.userId,
    required this.postId,
  });
}
