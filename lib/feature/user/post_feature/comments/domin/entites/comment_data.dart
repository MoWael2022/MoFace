import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int id;
  String commentext;
  final DateTime time;

  Comment({
    required this.id,
    required this.commentext,
    required this.time,
  });


  @override
  List<Object?> get props => [commentext, id, time];
}
