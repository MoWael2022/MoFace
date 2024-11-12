import 'package:equatable/equatable.dart';

class DataForGetPostIds extends Equatable {

  final String userId;

  const DataForGetPostIds({required this.userId});

  Map<String, String> toMap() {
    return {"userId": userId};
  }

  @override
  List<Object?> get props => [
    userId,
  ];
}
