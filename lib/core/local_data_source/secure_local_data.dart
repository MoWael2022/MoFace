import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mo_face_app/feature/auth_feature/domin/entites/user_data.dart';

class SecureStorageAuthHelper {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<String> isSignIn() async {
    final isSignIn = await _secureStorage.read(key: 'isSignIn') ?? 'false';
    return isSignIn;
  }

  static Future<String>getToken()async{
    final token = await _secureStorage.read(key: 'token') ?? 'false';
    return token;
  }

  static Future<String>getUserId()async{
    final id = await _secureStorage.read(key: 'id') ?? 'false';
    return id;
  }

  // Load saved email and password
  static Future<UserData> loadUserData() async {
    final email = await _secureStorage.read(key: 'email') ?? '';
    final token = await _secureStorage.read(key: 'token') ?? '';
    final id = await _secureStorage.read(key: 'id') ?? '';
    final name = await _secureStorage.read(key: 'username') ?? '';
    final photoImg = await _secureStorage.read(key: 'photoImg') ?? '';
    final backgroundImg = await _secureStorage.read(key: 'backgroundImg') ?? '';

    return UserData(
        email: email,
        name: name,
        backgroundImage: backgroundImg,
        rules: [],
        id: id,
        token: token,
        photoImage: photoImg);
  }

  // Save or delete user data based on rememberMe status
  static Future<void> saveUserData({
    required String isSignIn,
    required UserData userData,
    required String token,
  }) async {
    await _secureStorage.write(key: 'isSignIn', value: 'true');
    await _secureStorage.write(key: 'email', value: userData.email);
    await _secureStorage.write(key: 'token', value: token);
    await _secureStorage.write(key: 'username', value: userData.name);
    await _secureStorage.write(key: 'photoImg', value: userData.photoImage);
    await _secureStorage.write(
        key: 'backgroundImg', value: userData.backgroundImage);
    await _secureStorage.write(key: 'id', value: userData.id);
    //await _secureStorage.write(key: 'rules', value: rules);
  }

  //logout and delete userData
  static Future<void> deleteUserData({
    required bool isSignIn,
  }) async {
    await _secureStorage.write(key: 'isSignIn', value: 'false');
    await _secureStorage.delete(key: 'email');
    await _secureStorage.delete(key: 'token');
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'photoImg');
    await _secureStorage.delete(key: 'backgroundImg');
    await _secureStorage.delete(key: 'id');
  }
}
