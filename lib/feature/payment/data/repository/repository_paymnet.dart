
import '../../domin/entites/all_data_payment_entered.dart';
import '../../domin/entites/paymentDataToGetToken.dart';
import '../../domin/entites/payment_data_entered.dart';
import '../../domin/repository/base_repository_payment.dart';
import '../data_source/base_remote_data_source.dart';

class RepositoryPayment extends BaseRepositoryPayment {
  final BasePaymentRemoteDataSource _basePaymentRemoteDataSource;

  RepositoryPayment(this._basePaymentRemoteDataSource);

  @override
  Future<String> getPaymentToken(AllDataPaymentEnter allDataPaymentEnter) async {
    String authenticationToken =
        await _basePaymentRemoteDataSource.getAuthenticationToken();

    int getOrderId = await _basePaymentRemoteDataSource.getOrderId(
      PaymentDataEntered(
          token: authenticationToken,
          amount: allDataPaymentEnter.amount,
          currency: allDataPaymentEnter.currency),
    );
    String getPaymentToken =
        await _basePaymentRemoteDataSource.getAuthenticationId(
      PaymentDataToGetToken(
          authToken: authenticationToken,
          amountCents: allDataPaymentEnter.amount,
          currency: allDataPaymentEnter.currency,
          orderId: getOrderId,
          paymentType: allDataPaymentEnter.paymentType,
          email: allDataPaymentEnter.email,
          firstName: allDataPaymentEnter.firstName,
          lastName: allDataPaymentEnter.lastName,
          phoneNumber: allDataPaymentEnter.phoneNumber),
    );
    return getPaymentToken;
  }
}
