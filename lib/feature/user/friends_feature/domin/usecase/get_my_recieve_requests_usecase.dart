import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/base_use_case/base_use_case.dart';

import '../../../../../core/failure/failure.dart';
import '../entites/friend_data.dart';
import '../repository/base_friend_repository.dart';

class GetMyReceiveRequestUseCase extends BaseUseCase <String, List<FriendData>> {
  final BaseFriendRepository _baseFriendRepository;

  GetMyReceiveRequestUseCase(this._baseFriendRepository);

  @override
  Future<Either<Failure, List<FriendData>>> call(String input) async {
    return await _baseFriendRepository.getMyRequestReceiveRepository(input);
  }
}