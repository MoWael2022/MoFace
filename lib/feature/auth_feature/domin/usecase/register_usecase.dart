import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/auth_feature/domin/repository/base_repository.dart';
import '../../../../core/failure/failure.dart';
import '../entites/user_data.dart';
import '../entites/user_data_for_register.dart';
import '../../../../core/base_use_case/base_use_case.dart';



class RegisterUseCase extends BaseUseCase<UserDataForRegister, UserData> {
  final BaseAuthRepository _baseUserRepository;

  RegisterUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, UserData>> call(UserDataForRegister input) async {
    return await _baseUserRepository.registerRepository(input);
  }
}
