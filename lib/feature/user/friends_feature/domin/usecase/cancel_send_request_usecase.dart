import 'package:dartz/dartz.dart';

import '../../../../../core/base_use_case/base_use_case.dart';
import '../../../../../core/failure/failure.dart';
import '../entites/send_request_data_enter.dart';
import '../repository/base_friend_repository.dart';

class CancelRequestUseCase extends BaseUseCase<RequestDataEnter, bool> {
  final BaseFriendRepository _baseFriendRepository;

  CancelRequestUseCase(this._baseFriendRepository);

  @override
  Future<Either<Failure, bool>> call(RequestDataEnter input) async {
    return await _baseFriendRepository.cancelRequestRepository(input);
  }
}
