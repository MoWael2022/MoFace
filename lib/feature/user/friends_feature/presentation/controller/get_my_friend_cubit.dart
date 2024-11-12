import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_friend_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';

import '../../../../../core/user_data/user_data_provider.dart';

class GetMyFriendCubit extends Cubit<BaseFriendState> {
  GetMyFriendUseCase getMyFriendUseCase;

  GetMyFriendCubit({required this.getMyFriendUseCase}) : super(InitState());

  final user = UserDataProvider().userData;

  getMyFriends() async {
    emit(LoadingFriendState());
    final data = await getMyFriendUseCase.call(user!.id);
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      emit(LoadedMyFriendsState(r));
    });
  }
}
