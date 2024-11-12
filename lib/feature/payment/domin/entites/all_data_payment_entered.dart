import 'package:equatable/equatable.dart';

class AllDataPaymentEnter extends Equatable {
  final int amount;

  final String currency;

  final bool paymentType;
  final String email;
  final String firstName;
  final String lastName;

  final String phoneNumber;

  @override
  List<Object?> get props => [
        amount,
        currency,
        paymentType,
        email,
        firstName,
        lastName,
        phoneNumber,
      ];

  const AllDataPaymentEnter(
      {required this.amount,
      required this.currency,
      required this.paymentType,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});
}
