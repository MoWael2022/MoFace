import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_friend_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_recieve_requests_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_send_requests_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_suggestion_friend_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';

import '../../../../../core/user_data/user_data_provider.dart';

class GetMyReceiveRequestCubit extends Cubit<BaseFriendState> {
  GetMyReceiveRequestUseCase getMyReceiveRequestUseCase;

  GetMyReceiveRequestCubit({required this.getMyReceiveRequestUseCase})
      : super(InitState()) {
    getMyReceiveRequests();
  }

  final user = UserDataProvider().userData;

  getMyReceiveRequests() async {
    emit(LoadingFriendState());
    final data = await getMyReceiveRequestUseCase.call(user!.id);
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      emit(LoadedMyReceiveRequestState(r));
    });
  }
}
