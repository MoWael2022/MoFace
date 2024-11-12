import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/failure/failure.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/data/data_source/react_remote_data_source.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/entites/react_data_enter.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/repository/base_react_repository.dart';

class ReactRepository implements BaseReactRepository {
  final ReactRemoteDataSource _reactRemoteDataSource;

  ReactRepository(this._reactRemoteDataSource);

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (failure) {
      return Left(Failure(message: failure.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addReactRepository(
      ReactDataEnter reactDataEnter) {
    return _execute(() =>
        _reactRemoteDataSource.addReactRemoteDataSource(reactDataEnter));
  }

  @override
  Future<Either<Failure, bool>> deleteReactRepository(
      ReactDataEnter reactDataEnter) {
    return _execute(() =>
        _reactRemoteDataSource.deleteReactRemoteDataSource(reactDataEnter));
  }
}
