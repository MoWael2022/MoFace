import 'dart:js_interop';

import 'package:bloc/bloc.dart';
import 'package:moface/user/domin/entites/friends/friend_data.dart';
import 'package:moface/user/domin/entites/friends/friends_data_enter.dart';
import 'package:moface/user/domin/entites/friends/send_request_data_enter.dart';
import 'package:moface/user/domin/usecase/friends_data_usecase.dart';
import 'package:moface/user/domin/usecase/requests_usecase.dart';
import 'package:moface/user/presentation/controller/friends_state/friends_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service_locator.dart';
import '../../../domin/usecase/get_my_suggestions_friends_usecase.dart';

class FriendsCubit extends Cubit<BaseFriendsState> {
  FriendsCubit() : super(InitState()) {
    getMyFriends();
    //getSuggestionFriends();
    //getWaitingRequestFriends();
  }

  List<FriendData> suggestionFriends = [];
  List<FriendData> myFriends = [];
  List<FriendData> sendRequestFriends = [];
  List<FriendData> waitingRequestFriends = [];
  bool showDialogs =false;




  getSuggestionFriends() async {
    emit(LoadingSuggestionFriends());
    final data = instance<GetMySuggestionsFriendsUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result =
        await data.call(FriendsDataEnter(userId: idUser, token: token));
    result.fold((l) {}, (r) {
      emit(LoadedSuggestionFriends(r));
    });
  }

  getMyFriends() async {
    emit(LoadingMyFriends());
    final data = instance<FriendsDataUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result =
        await data.call(FriendsDataEnter(userId: idUser, token: token));
    result.fold((l) {}, (r) {
      //print(r);
      emit(LoadMyFriends(r));
    });
  }

  getSendRequestFriends() async {
    emit(LoadingSendRequestFriends());
    final data = instance<RequestSendUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result =
        await data.call(FriendsDataEnter(userId: idUser, token: token));
    result.fold((l) {}, (r) {
      emit(LoadedSendRequestFriends(r));
    });
  }

  getWaitingRequestFriends() async {
    emit(LoadingWaitingRequestFriends());
    final data = instance<RequestRecieveUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result =
    await data.call(FriendsDataEnter(userId: idUser, token: token));
    result.fold((l) {}, (r) {
      emit(LoadedWaitingRequestFriends(r));
    });
  }

  sendRequest(String friendId) async {
    final data = instance<SendRequestUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result = await data.call(
      RequestDataEnter(token: token, userId: idUser, friendId: friendId),
    );
    result.fold((l) {}, (r) {
      emit(SendRequestState());
    });
  }

  acceptRequest(String friendId) async {
    final data = instance<AcceptRequestUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result = await data.call(
      RequestDataEnter(token: token, userId: idUser, friendId: friendId),
    );
    result.fold((l) {}, (r) {
      emit(AcceptRequestState());
    });
  }

  cancelRequest(String friendId)async{
    final data = instance<CancelRequestUseCase>();
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result = await data.call(
      RequestDataEnter(token: token, userId: idUser, friendId: friendId),
    );
    result.fold((l) {}, (r) {
      emit(CancelRequestState(friendId));
    });
  }
}
