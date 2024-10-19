import 'package:equatable/equatable.dart';

class ErrorMessageRegister extends Equatable {
  final String title;

  final int statusCode;

  final Map<String, List<String>> errors;

  const ErrorMessageRegister(
      {required this.title, required this.statusCode, required this.errors});

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        statusCode,
        errors,
      ];
}
