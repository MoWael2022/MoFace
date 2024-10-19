import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/core/service_locator.dart';
import 'package:moface/user/domin/entites/chat/data_chat_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned_web_socket.dart';
import 'package:moface/user/domin/usecase/close_connection_usecase.dart';
import 'package:moface/user/domin/usecase/connect_to_web_socket_use_case.dart';
import 'package:moface/user/domin/usecase/get_chat_between_user_use_case.dart';
import 'package:moface/user/domin/usecase/listenToMessage.dart';
import 'package:moface/user/domin/usecase/save_connection_usecase.dart';
import 'package:moface/user/domin/usecase/send_message_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../domin/entites/friends/friend_data.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  StreamSubscription<DataChatReturnedWebSocket>? _messageSubscription;

  ChatCubit() : super(ChatInitial());

  String? connectionId;

  late WebSocketChannel _channel;

  FriendData? friendReceivedData;

  List<String> chatMessageSend = [];

  List<String> chatMessageReceived = [];

  final allMessages = <Map<String, dynamic>>[];

  // void connect(String userId) async {
  //   emit(ChatLoading());
  //
  //   final result = instance<ConnectToWebSocketUseCase>();
  //   await result.execute(); // Connect to the WebSocket
  //   print("WebSocket connected");
  //   //
  //   // _listenForMessages();
  //   //
  //   // saveConnection(userId);
  //
  //   emit(ChatConnected());
  //
  //   // Listen to incoming messages after connecting
  //
  // }

  void getMessageBetweenUsers(String receiverId) async {
    emit(ChatLoading());
    final sharedpref = await SharedPreferences.getInstance();
    String token = sharedpref.getString('token')!;
    String idUser = sharedpref.getString('id')!;
    final result = instance<GetChatBetweenUserUseCase>();
    final data = await result.call(
        DataChatEnter(token: token, senderId: idUser, receiverId: receiverId));
    data.fold((l){
      emit(ChatLoadedError(l.messageError));
    }, (r){
      for(DataChatReturned i in r){
        if(i.senderId == idUser){
          allMessages.add({
            "message" :i.messageText,
            "isReceived":false,
          });
        }else {
          allMessages.add({
            "message" :i.messageText,
            "isReceived":true,
          });
        }
      }
      emit(ChatLoaded(r));
    });

  }

  void connect(String userId) {
    emit(ChatLoading());
    final result = instance<ConnectToWebSocketUseCase>();
    final data = result.execute(userId); // Connect to the WebSocket
    data.listen((message) {
      if (message.target == "UserConnection") {
        emit(ChatConnected());
      } else if (message.target == "ReceiveMessage") {
        emit(ChatMessageReceived(message));
      }
    });
  }

  // void saveConnection(String userId) async {
  //   final result = instance<SaveConnectionUseCase>();
  //   await result.execute(userId);
  // }

  // void listenForMessages(String userId){
  //   // Cancel the existing subscription before starting a new one
  //   //_messageSubscription?.cancel();
  //
  //   final result = instance<ListenToMessages>();
  //   _messageSubscription = result.execute().listen((message) {
  //     print('Message received: $message');
  //     emit(ChatMessageReceived(message)); // Emit state when a new message arrives
  //   });
  //   saveConnection(userId);
  // }

  void sendChatMessage(String receiverId, String message) async {
    final result = instance<SendMessageUseCase>();
    await result.execute(receiverId, message, connectionId);
    emit(ChatMessageSent(message));
    // No need to re-listen for messages here, listening is already handled
  }

  @override
  Future<void> close() async {
    // Cancel message subscription on cubit close
    await _messageSubscription?.cancel();

    // Close the WebSocket connection
    final result = instance<CloseConnectionUseCase>();
    await result.execute();

    return super.close();
  }

  void showDialogsMethod(FriendData data) {
    friendReceivedData = data;
    emit(ShowDialogState());
  }

  void hideDialogsState() {
    emit(HideDialogsState());
  }
}
