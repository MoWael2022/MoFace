import 'dart:js_interop';

import '../../domin/entites/posts/user_posts.dart';

class UserViewPostModel extends UserPosts {
  const UserViewPostModel({required super.postsId});

  factory UserViewPostModel.fromJson(Map<String, dynamic> json) {
    return UserViewPostModel(postsId: json['posts']);
  }

  //
  // factory UserViewPostModel.fromJsArray(JSArray<JSAny> json){
  //   return UserViewPostModel(postsId: json.);
  // }
}
