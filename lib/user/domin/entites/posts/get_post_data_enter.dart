import 'package:equatable/equatable.dart';

class GetPostDataEnter extends Equatable {
  final String token;

  final String userId;

  final int id;

  const GetPostDataEnter(
      {required this.token, required this.id, required this.userId});

  @override
  List<Object?> get props => [token, id];
}
