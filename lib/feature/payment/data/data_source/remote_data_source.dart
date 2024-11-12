import 'package:dio/dio.dart';
import 'package:mo_face_app/core/dio_manager/dio_error_handlar.dart';

import '../../../../core/utilts/api_constant.dart';
import '../../domin/entites/paymentDataToGetToken.dart';
import '../../domin/entites/payment_data_entered.dart';
import 'base_remote_data_source.dart';

class PaymentRemoteDataSource extends BasePaymentRemoteDataSource {
  late Dio dio;

  PaymentRemoteDataSource() {
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 50), // Increase if needed
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 20),
    ));
  }

  @override
  Future<String> getAuthenticationToken() async {
    try {
      final response = await dio.post(Constant.authenticationToken, data: {
        "api_key": Constant.apiKey,
      });
      final data = response.data["token"];
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<int> getOrderId(PaymentDataEntered paymentData) async {
    try {
      final response =
          await dio.post(Constant.paymentId, data: paymentData.toMap());
      final data = response.data["id"];
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<String> getAuthenticationId(PaymentDataToGetToken paymentData) async {
    try {
      final response =
          await dio.post(Constant.paymentToken, data: paymentData.toMap());
      print("third authentication response ${response.data["token"]}.");
      final data = response.data["token"];
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }

  }
}
