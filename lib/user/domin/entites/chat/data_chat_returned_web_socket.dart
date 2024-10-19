import 'package:equatable/equatable.dart';

class DataChatReturnedWebSocket extends Equatable {
  final int type;
  final String target;
  final List<dynamic> arguments;

  @override
  List<Object?> get props => [type, target, arguments];

  const DataChatReturnedWebSocket(
      {required this.type, required this.target, required this.arguments});
}
