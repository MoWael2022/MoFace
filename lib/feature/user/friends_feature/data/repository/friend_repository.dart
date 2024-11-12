import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/user/friends_feature/data/data_source/base_friend_remote_data_source.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/entites/friend_data.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/entites/send_request_data_enter.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/repository/base_friend_repository.dart';

import '../../../../../core/failure/failure.dart';

class FriendRepository implements BaseFriendRepository {
  final BaseFriendRemoteDataSource _baseFriendRemoteDataSource;

  FriendRepository(this._baseFriendRemoteDataSource);

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (failure) {
      return Left(Failure(message: failure.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> acceptRequestRepository(RequestDataEnter data) {
    return _execute(
        () => _baseFriendRemoteDataSource.acceptRequestDataSource(data));
  }

  @override
  Future<Either<Failure, bool>> cancelRequestRepository(RequestDataEnter data) {
    return _execute(
        () => _baseFriendRemoteDataSource.cancelRequestDataSource(data));
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMyFriendsRepository(
      String userId) {
    return _execute(
        () => _baseFriendRemoteDataSource.getMyFriendsDataSource(userId));
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMyRequestReceiveRepository(
      String userId) {
    return _execute(() =>
        _baseFriendRemoteDataSource.getMyRequestReceiveDataSource(userId));
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMyRequestSendRepository(
      String userId) {
    return _execute(
        () => _baseFriendRemoteDataSource.getMyRequestsSendDataSource(userId));
  }

  @override
  Future<Either<Failure, List<FriendData>>> getMySuggestionFriendsRepository(
      String userId) {
    return _execute(() =>
        _baseFriendRemoteDataSource.getMySuggestionFriendsDataSource(userId));
  }

  @override
  Future<Either<Failure, bool>> sendRequestRepository(RequestDataEnter data) {
    return _execute(
        () => _baseFriendRemoteDataSource.sendRequestDataSource(data));
  }
}
