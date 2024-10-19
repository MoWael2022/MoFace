import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String email;

  final String name;

  final String id;

  final String token;

  String photoImage;

  String backgroundImgge;

  final List<dynamic> rules;

  UserData(
      {required this.email,
      required this.name,
      required this.backgroundImgge,
      required this.rules,
      required this.id,
      required this.token,
      required this.photoImage});

  UserData copyWith({
    String? email,
    String? name,
    String? backgroundImgge,
    List<String>? rules,
    String? id,
    String? token,
    String? photoImage,
  }) {
    return UserData(
      email: email ?? this.email,
      name: name ?? this.name,
      backgroundImgge: backgroundImgge ?? this.backgroundImgge,
      rules: rules ?? this.rules,
      id: id ?? this.id,
      token: token ?? this.token,
      photoImage: photoImage ?? this.photoImage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        email,
        photoImage,
        token,
        id,
      ];
}
