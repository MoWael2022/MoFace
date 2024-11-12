import '../../feature/auth_feature/domin/entites/user_data.dart';
import '../local_data_source/secure_local_data.dart';

class UserDataProvider {
  static final UserDataProvider _instance = UserDataProvider._internal();

  UserDataProvider._internal();

  UserData? _userData;

  factory UserDataProvider() {
    return _instance;
  }

  UserData? get userData => _userData;

  void setUserData(UserData data) {
    _userData = data;
  }

  void clearUserData(){
    _userData =null ;
  }

  Future<void> initializeUserData()async{
    final isSignIn = await SecureStorageAuthHelper.isSignIn();
    if(isSignIn =='true'){
      _userData = await SecureStorageAuthHelper.loadUserData();
    }

  }

}
