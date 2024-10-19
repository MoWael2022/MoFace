import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/userData.dart';
import 'package:moface/user/domin/entites/user_data_for_register.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class RegisterUseCase extends BaseUserUseCase<UserDataForRegister, UserData> {
  final BaseUserRepository _baseUserRepository;

  RegisterUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, UserData>> call(UserDataForRegister input) async {
    return await _baseUserRepository.registerRepository(input);
  }
}
