import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/auth_feature/domin/repository/base_repository.dart';
import '../../../../core/failure/failure.dart';
import '../entites/user_data.dart';
import '../entites/user_data_for_login.dart';
import '../../../../core/base_use_case/base_use_case.dart';


class LoginUseCase extends BaseUseCase<UserDataForLogin, UserData> {
  final BaseAuthRepository _baseUserRepository;

  LoginUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, UserData>> call(UserDataForLogin input) async {
    return await _baseUserRepository.loginRepository(input);
  }
}
