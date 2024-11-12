import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utilts/api_constant.dart';
import '../controller/payment_state.dart';
import '../controller/paymnet_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is LoadedState) {
          launchUrl(
            Uri.parse(
              Constant.iframePayment(state.token),
            ),
          );
        }
      },
      child: Card(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<PaymentCubit>(context)
                  .getPaymentToken(1000, "EGP", true, "010");
            },
            child: const Text("pay"),
          ),
        ),
      ),
    );
  }
}
