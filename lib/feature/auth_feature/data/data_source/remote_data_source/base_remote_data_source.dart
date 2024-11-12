import '../../../domin/entites/user_data_for_login.dart';
import '../../../domin/entites/user_data_for_register.dart';
import '../../model/user_data_model.dart';

abstract class BaseAuthRemoteUserDataSource {
  Future<UserDataModel> loginRemoteDataSource(
      UserDataForLogin userDataForLogin);

  Future<UserDataModel> registerRemoteDataSource(
      UserDataForRegister userDataForRegister);

  Future<UserDataModel> refreshTokenRemoteDataSource();

  Future<bool> ensureTokenValidationRemoteDataSource(String token);

  Future<bool> logoutRemoteDataSource(String token);

  Future<String> gwtEncryptRemoteDataSource(String token);
}
