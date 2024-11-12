import '../entites/all_data_payment_entered.dart';
import '../entites/paymentDataToGetToken.dart';
import '../entites/payment_data_entered.dart';

abstract class BaseRepositoryPayment {
  Future<String> getPaymentToken(AllDataPaymentEnter allDataPaymentEnter);
}
