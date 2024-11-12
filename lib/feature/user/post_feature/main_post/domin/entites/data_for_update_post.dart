import 'data_for_add_post.dart';

class DataForUpdatePost extends DataForAddPost {
  final int postId;

  const DataForUpdatePost(
      {required this.postId,
        required super.userId,
        required super.text,
        required super.color,
        super.webImage,
        super.image});
}
