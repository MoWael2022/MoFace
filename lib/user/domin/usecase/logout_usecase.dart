import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/userData.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';


class LogoutUseCase extends BaseUserUseCase<String, bool> {
  final BaseUserRepository _baseUserRepository;

  LogoutUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(input) async {
    return await _baseUserRepository.logoutRepository(input);
  }
}
