import 'package:dartz/dartz.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/entites/react_data_enter.dart';

import '../../../../../../core/failure/failure.dart';

abstract class BaseReactRepository {
  Future<Either<Failure, bool>> addReactRepository(
      ReactDataEnter addCommentDataEnter);

  Future<Either<Failure, bool>> deleteReactRepository(
      ReactDataEnter addCommentDataEnter);
}