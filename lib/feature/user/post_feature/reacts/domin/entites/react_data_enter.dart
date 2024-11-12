import 'package:equatable/equatable.dart';

class ReactDataEnter extends Equatable {
  final String userId;

  final int postId;


  Map<String, dynamic> toMap() {
    return {
      "postid": postId,
      "userid": userId,
    };
  }

  @override
  List<Object?> get props => [

        userId,
        postId,
      ];

  const ReactDataEnter({
    required this.userId,
    required this.postId,
  });
}

class DataEnterDeleteForPost extends ReactDataEnter {
  const DataEnterDeleteForPost(
      {required super.userId, required super.postId});


  Map<String, dynamic> convertToMap() {
    return {
      "iduser": userId,
      "idpost": postId,
    };
  }
}
