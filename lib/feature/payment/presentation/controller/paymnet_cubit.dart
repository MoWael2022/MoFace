import 'package:bloc/bloc.dart';
import 'package:mo_face_app/core/user_data/user_data_provider.dart';
import 'package:mo_face_app/feature/payment/presentation/controller/payment_state.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domin/entites/all_data_payment_entered.dart';
import '../../domin/usecase/payment_usecase.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentUseCase paymentUseCase;

  PaymentCubit(this.paymentUseCase) : super(InitState());

  final user =UserDataProvider().userData;

  void getPaymentToken(
      int amount, String currency, bool paymentType, String phoneNumber) async {
    emit(LoadingState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = user!.email;
    String userName = user!.name;
    try {
      await paymentUseCase(
        AllDataPaymentEnter(
            amount: amount,
            currency: currency,
            paymentType: paymentType,
            email: email,
            firstName: userName,
            lastName: userName,
            phoneNumber: phoneNumber),
      ).then((token) {
        print(token);
        emit(LoadedState(token));
      });
    } on Exception catch (e) {
      print(e.toString());
      emit(ErrorState());
    }
  }
}
