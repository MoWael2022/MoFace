import '../../domin/entites/react_entities.dart';

class ReactModel extends React {
  const ReactModel({
    required super.id,
    required super.userName,
    required super.profileimg,
  });

  factory ReactModel.fromJson(Map<String, dynamic> json) {
    return ReactModel(
      id: json['iduser'],
      userName: json['username'],
      profileimg: json['userimg'],
    );
  }
}