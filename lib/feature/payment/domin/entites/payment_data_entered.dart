import 'package:equatable/equatable.dart';

class PaymentDataEntered extends Equatable {
  final String token;
  final int amount;
  final String currency;
  final List<dynamic> items = [];
  final String deliveryNeeded = "false";

  PaymentDataEntered(
      {required this.token, required this.amount, required this.currency});

  String _getAmount() {
    return (amount * 100).toString();
  }

  Map<String,dynamic> toMap(){
    return {
      "auth_token":token,
      "amount_cents":_getAmount(),
      "currency":currency,
      "items":items,
      "delivery_needed":deliveryNeeded,
    };
  }

  @override
  List<Object?> get props => [
        token,
        amount,
        currency,
        items,
        deliveryNeeded,
      ];
}
