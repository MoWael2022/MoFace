import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/auth_feature/domin/repository/base_repository.dart';

import '../../../../core/failure/failure.dart';
import '../../domin/entites/user_data.dart';
import '../../domin/entites/user_data_for_login.dart';
import '../../domin/entites/user_data_for_register.dart';
import '../data_source/remote_data_source/base_remote_data_source.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthRemoteUserDataSource _baseAuthRemoteUserDataSource;

  AuthRepository(this._baseAuthRemoteUserDataSource);

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (failure) {
      return Left(failure as Failure);
    }
  }

  @override
  Future<Either<Failure, UserData>> registerRepository(
      UserDataForRegister userDataForRegister) async {
    return _execute(() => _baseAuthRemoteUserDataSource
        .registerRemoteDataSource(userDataForRegister));

    // try {
    //   final result = await _baseAuthRemoteUserDataSource
    //       .registerRemoteDataSource(userDataForRegister);
    //   return Right(result);
    // } catch (failure) {
    //   return Left(failure as Failure);
    // }
  }

  @override
  Future<Either<Failure, UserData>> loginRepository(
      UserDataForLogin userDataForLogin) async {
    return _execute(() =>
        _baseAuthRemoteUserDataSource.loginRemoteDataSource(userDataForLogin));
    // try {
    //   final result = await _baseAuthRemoteUserDataSource
    //       .loginRemoteDataSource(userDataForLogin);
    //   return Right(result);
    // } catch (failure) {
    //   return Left(failure as Failure);
    // }
  }

  @override
  Future<Either<Failure, UserData>> refreshTokenRepository() async {
    return _execute(
        () => _baseAuthRemoteUserDataSource.refreshTokenRemoteDataSource());
    // try {
    //   final result =
    //       await _baseAuthRemoteUserDataSource.refreshTokenRemoteDataSource();
    //   return Right(result);
    // } catch (failure) {
    //   return Left(failure as Failure);
    // }
  }

  @override
  Future<Either<Failure, bool>> checkTokenValidationRepository(
      String token) async {
    return _execute(() => _baseAuthRemoteUserDataSource
        .ensureTokenValidationRemoteDataSource(token));
    // try {
    //   final result = await _baseAuthRemoteUserDataSource
    //       .ensureTokenValidationRemoteDataSource(token);
    //   return Right(result);
    // } catch (failure) {
    //   return Left(failure as Failure);
    // }
  }

  @override
  Future<Either<Failure, String>> gwtRepository(String token) async {
    return _execute(
        () => _baseAuthRemoteUserDataSource.gwtEncryptRemoteDataSource(token));
    // try {
    //   final result =
    //       await _baseAuthRemoteUserDataSource.gwtEncryptRemoteDataSource(token);
    //   return Right(result);
    // } catch (failure) {
    //   return Left(failure as Failure);
    // }
  }

  @override
  Future<Either<Failure, bool>> logoutRepository(String token) async {
    return _execute(
        () => _baseAuthRemoteUserDataSource.logoutRemoteDataSource(token));
    // try {
    //   final result =
    //       await _baseAuthRemoteUserDataSource.logoutRemoteDataSource(token);
    //   return Right(result);
    // } catch (failure) {
    //   return Left(failure as Failure);
    // }
  }
}
