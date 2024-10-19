import 'package:moface/user/domin/entites/userData.dart';

class UserDataModel extends UserData {
   UserDataModel(
      {required super.email,
      required super.name,
      required super.id,
      required super.backgroundImgge,
      required super.token,
      required super.photoImage,
      required super.rules});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      backgroundImgge: json['backgroundimg'],
      email: json['email'],
      name: json['username'],
      id: json['userid'],
      token: json['encreptedToken'],
      photoImage: json['profileimg'],
      rules: json['roles'],
    );
  }
}
