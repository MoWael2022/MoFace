import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/friends/send_request_data_enter.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class SendRequestUseCase extends BaseUserUseCase<RequestDataEnter, bool> {
  final BaseUserRepository _baseUserRepository;

  SendRequestUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(RequestDataEnter input) async {
    return await _baseUserRepository.sendRequestRepository(input);
  }
}

class AcceptRequestUseCase extends BaseUserUseCase<RequestDataEnter, bool> {
  final BaseUserRepository _baseUserRepository;

  AcceptRequestUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(RequestDataEnter input) async {
    return await _baseUserRepository.acceptRequestRepository(input);
  }
}

class CancelRequestUseCase extends BaseUserUseCase<RequestDataEnter, bool> {
  final BaseUserRepository _baseUserRepository;

  CancelRequestUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, bool>> call(RequestDataEnter input) async {
    return await _baseUserRepository.cancelRequestRepository(input);
  }
}
