import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/repository/base_friend_repository.dart';

import '../../../../../core/base_use_case/base_use_case.dart';
import '../../../../../core/failure/failure.dart';
import '../entites/send_request_data_enter.dart';

class SendRequestUseCase extends BaseUseCase<RequestDataEnter, bool> {
  final BaseFriendRepository _baseFriendRepository;

  SendRequestUseCase(this._baseFriendRepository);

  @override
  Future<Either<Failure, bool>> call(RequestDataEnter input) async {
    return await _baseFriendRepository.sendRequestRepository(input);
  }
}
