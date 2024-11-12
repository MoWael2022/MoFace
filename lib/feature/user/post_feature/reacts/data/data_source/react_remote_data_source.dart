import 'package:dio/dio.dart';

import '../../../../../../core/dio_manager/dio_client.dart';
import '../../../../../../core/dio_manager/dio_error_handlar.dart';
import '../../../../../../core/utilts/api_constant.dart';
import '../../domin/entites/react_data_enter.dart';

class ReactRemoteDataSource {
  final Dio _dio = DioClient.instance.dio;

  Future<bool> addReactRemoteDataSource(ReactDataEnter reactDataEnter) async {
    try {
      FormData formData = FormData.fromMap(reactDataEnter.toMap());
      String path = Constant.react;
      await _dio.post(path, data: formData);

      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<bool> deleteReactRemoteDataSource(ReactDataEnter reactDataEnter) async {
    try {
      FormData formData = FormData.fromMap(reactDataEnter.toMap());
      String path = Constant.react;
      await _dio.delete(path, data: formData);

      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
