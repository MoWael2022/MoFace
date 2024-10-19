import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned_web_socket.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class ConnectToWebSocketUseCase {
  final BaseUserRepository _baseUserRepository;

  ConnectToWebSocketUseCase(this._baseUserRepository);

  Stream<DataChatReturnedWebSocket> execute(String userId) {
    return _baseUserRepository.connect(userId);
  }
}
