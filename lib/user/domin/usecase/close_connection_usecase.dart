import 'package:moface/user/domin/repository/base_user_repository.dart';

class CloseConnectionUseCase {
  final BaseUserRepository _baseUserRepository;

  CloseConnectionUseCase(this._baseUserRepository);

  Future<void> execute() async {
    return await _baseUserRepository.closeConnectionRepository();
  }
}
