import '../entites/all_data_payment_entered.dart';
import '../repository/base_repository_payment.dart';

class PaymentUseCase {
  final BaseRepositoryPayment _baseRepositoryPayment;

  PaymentUseCase(this._baseRepositoryPayment);

  Future<String> call(AllDataPaymentEnter allDataPaymentEnter) async {
    return await _baseRepositoryPayment.getPaymentToken(allDataPaymentEnter);
  }
}
