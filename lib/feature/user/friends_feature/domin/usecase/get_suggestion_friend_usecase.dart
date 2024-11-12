
import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/entites/friend_data.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/repository/base_friend_repository.dart';

import '../../../../../core/base_use_case/base_use_case.dart';
import '../../../../../core/failure/failure.dart';

class GetSuggestionFriendUseCase
    extends BaseUseCase<String, List<FriendData>> {
  final BaseFriendRepository _baseFriendRepository;

  GetSuggestionFriendUseCase(this._baseFriendRepository);

  @override
  Future<Either<Failure, List<FriendData>>> call(String input) async {
    return await _baseFriendRepository.getMySuggestionFriendsRepository(input);
  }
}