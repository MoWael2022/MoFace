import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/userData.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';


class RefreshTokenUseCase extends BaseUserUseCase<NoParameter, UserData> {
  final BaseUserRepository _baseUserRepository;

  RefreshTokenUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, UserData>> call(input) async {
    return await _baseUserRepository.refreshTokenRepository();
  }
}


class GWTUseCase extends BaseUserUseCase<String, String> {
  final BaseUserRepository _baseUserRepository;

  GWTUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, String>> call(input) async {
    return await _baseUserRepository.GWTRepository(input);
  }
}