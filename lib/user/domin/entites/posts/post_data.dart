import 'package:equatable/equatable.dart';

class PostData extends Equatable {
  final int id;

  String text;
  String time;

  final int numOfReact;

  final int numOfComments;
  String? image;

  PostData(
      {required this.id,
      required this.text,
      required this.time,
      required this.numOfReact,
      required this.numOfComments,
      this.image});

  @override
  List<Object?> get props => [id, text, time, numOfReact, numOfComments, image];
}
