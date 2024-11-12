import '../../domin/entites/paymentDataToGetToken.dart';
import '../../domin/entites/payment_data_entered.dart';

abstract class BasePaymentRemoteDataSource {
  Future<String> getAuthenticationToken();
  Future<int> getOrderId(PaymentDataEntered paymentData);
  Future<String> getAuthenticationId(PaymentDataToGetToken paymentData);

}