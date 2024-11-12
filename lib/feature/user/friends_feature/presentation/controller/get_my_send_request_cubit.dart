import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/cancel_send_request_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_send_requests_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';
import '../../../../../core/user_data/user_data_provider.dart';

class GetMySendRequestCubit extends Cubit<BaseFriendState> {
  GetMySendRequestsUseCase getMySendRequestsUseCase;

  GetMySendRequestCubit({required this.getMySendRequestsUseCase})
      : super(InitState()){
    getMySendRequestsFriend();
  }

  final user = UserDataProvider().userData;

  getMySendRequestsFriend() async {
    emit(LoadingFriendState());
    final data = await getMySendRequestsUseCase.call(user!.id);
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      emit(LoadedMySendRequestsState(r));
    });
  }
}
