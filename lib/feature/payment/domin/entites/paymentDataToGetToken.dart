import 'package:equatable/equatable.dart';

import '../../../../core/utilts/api_constant.dart';

class PaymentDataToGetToken extends Equatable {
  final String authToken;
  final int amountCents;
  final int expiration;
  final String currency;
  final int orderId;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String lockOrderWhenPaid;
  final String apartment;
  final String floor;
  final String state;
  final String country;
  final String city;
  final String postalCode;
  final String shippingMethod;
  final String building;
  final String street;
  final bool paymentType;

  String _getIntegrationId() {
    return paymentType
        ? Constant.onlineCardPaymentIntegrationId
        : Constant.kioskPaymentIntegrationId;
  }

  const PaymentDataToGetToken({
    required this.authToken,
    required this.amountCents,
    required this.paymentType,
    this.expiration = 3600,
    required this.currency,
    required this.orderId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.lockOrderWhenPaid = "false",
    this.apartment = "NA",
    this.floor = "NA",
    this.state = "NA",
    this.country = "NA",
    this.city = "NA",
    this.postalCode = "NA",
    this.shippingMethod = "NA",
    this.building = "NA",
    this.street = "NA",
  });

  String _getAmount() {
    return (amountCents * 100).toString();
  }

  Map<String, dynamic> toMap() {
    return {
      "auth_token": authToken,
      "amount_cents": _getAmount(),
      "expiration": expiration,
      "currency": currency,
      "order_id": orderId,
      "integration_id": _getIntegrationId(),
      "billing_data": {
        "apartment": apartment,
        "email": email,
        "floor": floor,
        "first_name": firstName,
        "street": street,
        "building": building,
        "phone_number": phoneNumber,
        "shipping_method": shippingMethod,
        "postal_code": postalCode,
        "city": city,
        "country": country,
        "last_name": lastName,
        "state": state,
      },
      "lock_order_when_paid": lockOrderWhenPaid,
    };
  }

  @override
  List<Object?> get props => [
        authToken,
        amountCents,
        expiration,
        currency,
        orderId,
        email,
        firstName,
        lastName,
        phoneNumber,
        lockOrderWhenPaid,
        apartment,
        floor,
        state,
        country,
        city,
        postalCode,
        shippingMethod,
        building,
        paymentType,
        street,
      ];
}
