import 'package:dio/dio.dart';
import '../local_data_source/secure_local_data.dart';
import '../utilts/api_constant.dart';

class DioClient {
  Dio? _dio;

  // Private constructor for Singleton pattern
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();

  // Singleton instance getter
  static DioClient get instance => _instance;

  // Async function to initialize Dio with token
  Future<void> initialize() async {
    final token = await SecureStorageAuthHelper.getToken();
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  // Getter to access the Dio instance
  Dio get dio {
    if (_dio == null) {
      throw Exception('DioClient is not initialized. Call initialize() first.');
    }
    return _dio!;
  }
}
