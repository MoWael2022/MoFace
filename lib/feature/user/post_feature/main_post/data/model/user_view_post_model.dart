import 'dart:js_interop';

import '../../domin/entites/postsIds.dart';


class PostIdsModel extends PostsIds {
  const PostIdsModel({required super.postsId});

  factory PostIdsModel.fromJson(Map<String, dynamic> json) {
    return PostIdsModel(postsId: json['posts']);
  }

}
