import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/entites/send_request_data_enter.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/accept_request_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/cancel_send_request_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/send_request_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';

import '../../../../../core/user_data/user_data_provider.dart';

class ManageFriendCubit extends Cubit<BaseFriendState> {
  SendRequestUseCase sendRequestUseCase;

  AcceptRequestUseCase acceptRequestUseCase;
  CancelRequestUseCase cancelRequestUseCase;

  ManageFriendCubit(
      {required this.cancelRequestUseCase,
      required this.acceptRequestUseCase,
      required this.sendRequestUseCase})
      : super(InitState());

  final user = UserDataProvider().userData;

  sendRequest(String friendId) async {
    //emit(LoadingFriendState());
    final data = await sendRequestUseCase
        .call(RequestDataEnter(userId: user!.id, friendId: friendId));
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      emit(SendRequestState(friendId));
    });
  }

  acceptRequest(String friendId) async {
    //emit(LoadingFriendState());
    final data = await acceptRequestUseCase
        .call(RequestDataEnter(userId: user!.id, friendId: friendId));
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      emit(AcceptRequestState());
    });
  }

  cancelRequest(String friendId) async {
    //emit(LoadingFriendState());
    final data = await cancelRequestUseCase
        .call(RequestDataEnter(userId: user!.id, friendId: friendId));
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      emit(CancelRequestState());
    });
  }
}
