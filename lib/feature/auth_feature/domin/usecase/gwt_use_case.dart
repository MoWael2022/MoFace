import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/auth_feature/domin/repository/base_repository.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/base_use_case/base_use_case.dart';

class GWTUseCase extends BaseUseCase<String, String> {
  final BaseAuthRepository _baseUserRepository;

  GWTUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, String>> call(input) async {
    return await _baseUserRepository.gwtRepository(input);
  }
}