import 'package:bloc/bloc.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_my_friend_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/domin/usecase/get_suggestion_friend_usecase.dart';
import 'package:mo_face_app/feature/user/friends_feature/presentation/controller/base_friend_state.dart';

import '../../../../../core/user_data/user_data_provider.dart';

class GetSuggestionFriendCubit extends Cubit<BaseFriendState> {
  GetSuggestionFriendUseCase getSuggestionFriendUseCase;

  GetSuggestionFriendCubit({required this.getSuggestionFriendUseCase}) : super(InitState()){
    getSuggestionFriends();
  }

  final user = UserDataProvider().userData;

  getSuggestionFriends() async {
    emit(LoadingFriendState());
    final data = await getSuggestionFriendUseCase.call(user!.id);
    data.fold((l) {
      emit(ErrorOccurred(l.message));
    }, (r) {
      emit(LoadedSuggestionFriendsState(r));
    });
  }
}
