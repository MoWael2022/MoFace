import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/friends/friend_data.dart';
import 'package:moface/user/domin/entites/friends/friends_data_enter.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class GetMySuggestionsFriendsUseCase
    extends BaseUserUseCase<FriendsDataEnter, List<FriendData>> {
  final BaseUserRepository _baseUserRepository;

  GetMySuggestionsFriendsUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, List<FriendData>>> call(FriendsDataEnter input) async {
    return await _baseUserRepository.getMySuggestionFriendsRepository(input);
  }
}
