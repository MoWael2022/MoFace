import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/domin/usecase/add_react_use_case.dart';
import 'package:mo_face_app/feature/user/post_feature/reacts/presentation/controller/react_state.dart';

import '../../../../../../core/local_data_source/secure_local_data.dart';
import '../../../../../../core/user_data/user_data_provider.dart';
import '../../domin/entites/react_data_enter.dart';
import '../../domin/usecase/delete_react_use_case.dart';

class ReactCubit extends Cubit<ReactState> {
  AddReactUseCase addReactUseCase;
  DeleteReactUseCase deleteReactUseCase;

  ReactCubit({required this.deleteReactUseCase, required this.addReactUseCase})
      : super(InitState());

  final userId  = UserDataProvider().userData!.id;

  int reacts = 0;

  addReact(int postId) async {
    emit(AddReactState(postId));
    final result = await addReactUseCase.call(ReactDataEnter(
      userId: userId,
      postId: postId,
    ));
    result.fold((l) {
      emit(ErrorReactState(l.message));
    }, (r) {

    });
  }

  deleteReact(int postId) async {
    emit(DeleteReactState(postId));
    final result = await deleteReactUseCase.call(ReactDataEnter(
      userId: userId,
      postId: postId,
    ));
    result.fold((l) {
      emit(ErrorReactState(l.message));
    }, (r) {});
  }
}
