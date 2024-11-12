import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

import '../entites/user_data.dart';
import '../repository/base_repository.dart';

import '../../../../core/base_use_case/base_use_case.dart';

class RefreshTokenUseCase extends BaseUseCase<NoParameter, UserData> {
  final BaseAuthRepository _baseUserRepository;

  RefreshTokenUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, UserData>> call(input) async {
    return await _baseUserRepository.refreshTokenRepository();
  }
}
