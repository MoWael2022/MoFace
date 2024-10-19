import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/friends/friend_data.dart';
import 'package:moface/user/domin/entites/friends/friends_data_enter.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class FriendsDataUseCase
    extends BaseUserUseCase<FriendsDataEnter, List<FriendData>> {
  final BaseUserRepository _baseUserRepository;

  FriendsDataUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, List<FriendData>>> call(FriendsDataEnter input) async {
    return await _baseUserRepository.getMyFriendsRepository(input);
  }
}

class RequestRecieveUseCase
    extends BaseUserUseCase<FriendsDataEnter, List<FriendData>> {
  final BaseUserRepository _baseUserRepository;

  RequestRecieveUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, List<FriendData>>> call(FriendsDataEnter input) async {
    return await _baseUserRepository.getMyRequestReceiveRepository(input);
  }
}

class RequestSendUseCase
    extends BaseUserUseCase<FriendsDataEnter, List<FriendData>> {
  final BaseUserRepository _baseUserRepository;

  RequestSendUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, List<FriendData>>> call(FriendsDataEnter input) async {
    return await _baseUserRepository.getMyRequestSendRepository(input);
  }
}
