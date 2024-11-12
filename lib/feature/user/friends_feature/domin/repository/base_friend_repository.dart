import 'package:dartz/dartz.dart';

import '../../../../../core/failure/failure.dart';
import '../entites/friend_data.dart';
import '../entites/send_request_data_enter.dart';

abstract class BaseFriendRepository {
  Future<Either<Failure, List<FriendData>>> getMyFriendsRepository(
      String userId);

  Future<Either<Failure, List<FriendData>>> getMySuggestionFriendsRepository(
      String userId);

  Future<Either<Failure, List<FriendData>>> getMyRequestSendRepository(
      String userId);

  Future<Either<Failure, List<FriendData>>> getMyRequestReceiveRepository(
      String userId);

  Future<Either<Failure, bool>> sendRequestRepository(RequestDataEnter data);

  Future<Either<Failure, bool>> acceptRequestRepository(RequestDataEnter data);

  Future<Either<Failure, bool>> cancelRequestRepository(RequestDataEnter data);
}
