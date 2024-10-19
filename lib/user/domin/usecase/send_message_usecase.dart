import 'package:moface/user/domin/repository/base_user_repository.dart';

class SendMessageUseCase {
  final BaseUserRepository _baseUserRepository;

  SendMessageUseCase(this._baseUserRepository);

  Future<void> execute(
      String receiverId, String message, String? connectionId) async {
    return await _baseUserRepository.sendMessage(
        receiverId: receiverId, message: message);
  }
}
