import 'package:equatable/equatable.dart';

class DataForGetPostData extends Equatable {
  final String userId;

  final int id;

  const DataForGetPostData({required this.id, required this.userId});

  @override
  List<Object?> get props => [
        userId,
        id,
      ];
}
