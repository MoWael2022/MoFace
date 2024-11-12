
import '../../domin/entites/post_data.dart';

class PostDataModel extends PostData {
    PostDataModel(
      {required super.id,
      required super.text,
      required super.time,
      required super.numOfReact,
      super.image,
      required super.numOfComments});

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    return PostDataModel(
        id: json['post']['id'],
        text: json['post']['text'],
        time: json['post']['time'],
        numOfReact: json['post']['numofreact'],
        numOfComments: json['post']['numofcomment'],
        image: json['post']['image']);
  }
   factory PostDataModel.fromJsonForCommentAndReacts(Map<String, dynamic> json) {
     return PostDataModel(
         id: json['id'],
         text: json['text'],
         time: json['time'],
         numOfReact: json['numofreact'],
         numOfComments: json['numofcomment'],
         image: json['image']);
   }
}
