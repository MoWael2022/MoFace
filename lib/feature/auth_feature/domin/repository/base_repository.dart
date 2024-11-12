import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entites/user_data.dart';
import '../entites/user_data_for_login.dart';
import '../entites/user_data_for_register.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure ,UserData>> registerRepository(UserDataForRegister userDataForRegister);
  Future<Either<Failure ,UserData>> loginRepository(UserDataForLogin userDataForLogin);
  Future<Either<Failure ,UserData>> refreshTokenRepository();
  Future<Either<Failure ,bool>> checkTokenValidationRepository(String token);
  Future<Either<Failure ,bool>> logoutRepository(String token);
  Future<Either<Failure ,String>> gwtRepository(String token);
}