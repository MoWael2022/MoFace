import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/auth_feature/domin/repository/base_repository.dart';
import 'package:mo_face_app/core/base_use_case/base_use_case.dart';
import '../../../../core/failure/failure.dart';



class EnsureTokenValidationUseCase extends BaseUseCase<String, bool> {
  final BaseAuthRepository _baseUserRepository;

  EnsureTokenValidationUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(input) async {
    return await _baseUserRepository.checkTokenValidationRepository(input);
  }
}
