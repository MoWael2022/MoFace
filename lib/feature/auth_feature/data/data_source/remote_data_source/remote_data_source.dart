import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:mo_face_app/core/dio_manager/dio_error_handlar.dart';
import 'package:mo_face_app/feature/auth_feature/data/data_source/remote_data_source/base_remote_data_source.dart';

import '../../../../../core/utilts/api_constant.dart';
import '../../../domin/entites/user_data_for_login.dart';
import '../../../domin/entites/user_data_for_register.dart';
import '../../model/user_data_model.dart';

class RemoteAuthDataSource implements BaseAuthRemoteUserDataSource {
  late Dio dio;
  late CookieJar cookieJar;

  RemoteAuthDataSource() {
    // Initialize Dio and CookieJar
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 50), // Increase if needed
      receiveTimeout: const Duration(seconds: 50),
      sendTimeout: const Duration(seconds: 20),
    ));

    // Set up the PersistCookieJar to persist cookies across app restarts
    //_setupCookieManager();
  }

// Future<void> _setupCookieManager() async {
//   if (Platform.isAndroid) {
//     final appDocDir = await getApplicationDocumentsDirectory();
//     final cookieDir = p.join(appDocDir.path, "cookies");
//     cookieJar = PersistCookieJar(storage: FileStorage(cookieDir));
//
//     // Attach the CookieManager to Dio
//     dio.interceptors.add(CookieManager(cookieJar));
//   }
// }

  @override
  Future<String> gwtEncryptRemoteDataSource(String token) async {
    const String path = Constant.decryptToken;
    FormData formData = FormData.fromMap({
      "encrypttext": token,
    });

    try {
      final response = await dio.post(path, data: formData);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<UserDataModel> loginRemoteDataSource(
      UserDataForLogin userDataForLogin) async {
    // await _setupCookieManager();

    const String path = Constant.login;
    FormData formData = FormData.fromMap(userDataForLogin.toMap());

    try {
      final response = await dio.post(path, data: formData);
      // final rawCookies = response.headers.map;
      // print(rawCookies);
      //final cookie = html.document.cookie;
      //print(cookie);
      //print(rawCookies);
      //html.window.document.cookie = ',m';
      final data = UserDataModel.fromJson(response.data);

      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<UserDataModel> registerRemoteDataSource(
      UserDataForRegister userDataForRegister) async {
    // await _setupCookieManager();

    const String path = Constant.register;
    FormData formData = FormData.fromMap(userDataForRegister.toMap());

    try {
      final response = await dio.post(path, data: formData);
      final data = UserDataModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<UserDataModel> refreshTokenRemoteDataSource() async {
    // await _setupCookieManager();

    const String path = Constant.refreshToken;

    try {
      final response = await dio.get(path);
      final data = UserDataModel.fromJson(response.data);
      return data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<bool> ensureTokenValidationRemoteDataSource(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    const String path = Constant.ensureTokenValidation;
    try {
      await dio.get(path,
          options: Options(
            headers: headers,
          ));
      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future<bool> logoutRemoteDataSource(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
      const String path = Constant.logout;
      await dio.post(path,
          options: Options(
            headers: headers,
          ));
      return true;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
