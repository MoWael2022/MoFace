import '../../domin/entites/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel(
      {required super.email,
      required super.name,
      required super.id,
      required super.backgroundImage,
      required super.token,
      required super.photoImage,
      required super.rules});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      backgroundImage: json['backgroundimg'],
      email: json['email'],
      name: json['username'],
      id: json['userid'],
      token: json['encreptedToken'],
      photoImage: json['profileimg'],
      rules: json['roles'],
    );
  }
}
