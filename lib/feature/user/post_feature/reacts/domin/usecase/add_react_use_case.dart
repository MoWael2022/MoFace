import 'package:dartz/dartz.dart';
import 'package:mo_face_app/core/base_use_case/base_use_case.dart';
import 'package:mo_face_app/core/failure/failure.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/entites/react_data_enter.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/repository/base_react_repository.dart';

class AddReactUseCase extends BaseUseCase<ReactDataEnter, bool> {
  final BaseReactRepository _baseReactRepository;

  AddReactUseCase(this._baseReactRepository);

  @override
  Future<Either<Failure, bool>> call(ReactDataEnter input) async {
    return await _baseReactRepository.addReactRepository(input);
  }
}
