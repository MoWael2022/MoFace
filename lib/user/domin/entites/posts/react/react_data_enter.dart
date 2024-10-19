import 'package:equatable/equatable.dart';

class ReactDataEnter extends Equatable {
  final String userId;

  final int postId;

  final String token;

  Map<String, dynamic> toMap() {
    return {
      "postid": postId,
      "userid": userId,
    };
  }

  @override
  List<Object?> get props => [
        token,
        userId,
        postId,
      ];

  const ReactDataEnter({
    required this.userId,
    required this.postId,
    required this.token,
  });
}

class DataEnterDeleteForPost extends ReactDataEnter {
  const DataEnterDeleteForPost(
      {required super.userId, required super.postId, required super.token});


  Map<String, dynamic> convertToMap() {
    return {
      "iduser": userId,
      "idpost": postId,
    };
  }
}
