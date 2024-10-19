import 'package:dartz/dartz.dart';
import 'package:moface/core/failure/failure.dart';
import 'package:moface/user/domin/entites/chat/data_chat_enter.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned.dart';
import 'package:moface/user/domin/repository/base_user_repository.dart';
import 'package:moface/user/domin/usecase/base_user_usecase.dart';

class GetChatBetweenUserUseCase
    extends BaseUserUseCase<DataChatEnter, List<DataChatReturned>> {
  final BaseUserRepository _baseUserRepository;

  GetChatBetweenUserUseCase(this._baseUserRepository);

  @override
  Future<Either<Failure, List<DataChatReturned>>> call(
      DataChatEnter input) async {
    return await _baseUserRepository.getChatBetweenUsersRepo(input);
  }
}
